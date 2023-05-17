# pylint: skip-file
import spidev
import time
import serial
import RPi.GPIO as GPIO
import math
from subprocess import check_output

# LCD
rs = 21
enable = 20

# PCF8574
sda = 27
scl = 22
address = 0x38

# JOYSTICK
knop_joystick = 27

# SEGMENT DISPLAY
knop_display = 27

# LEDS
red = 5
green = 13
blue = 19


class Main:
    def __init__(self, knop, r, g, b):
        GPIO.setmode(GPIO.BCM)
        GPIO.setwarnings(False)

        # statussen voor joystick: 0 = IPs, 1 = vrx, 2 = vry
        self.status = 0

        self.mcp = MCP()
        self.pcf = PCF(sda, scl, address)
        self.lcd = LCD(rs, enable, self.pcf)
        self.display = Display(knop_display)
        # leds
        self.rode_led = PWM_led(r)
        self.groene_led = PWM_led(g)
        self.blauwe_led = PWM_led(b)
        self.leds = [self.rode_led, self.groene_led, self.blauwe_led]

        # joystick
        self.aantal = 0
        GPIO.setup(knop, GPIO.IN, GPIO.PUD_UP)
        # GPIO.add_event_detect(knop, GPIO.FALLING, self.joystick_callback, bouncetime=2000)

    def print_joystick(self):
        print(self.read_x(), self.read_y())

    def change_leds(self, leds):
        x_val = self.read_x()
        y_val = self.read_y()
        leds[0].set_duty_cycle(PWM_led.value_to_percent(x_val))
        leds[1].set_duty_cycle(PWM_led.value_to_percent(y_val))
        avg = PWM_led.average(x_val, y_val)
        leds[2].set_duty_cycle(PWM_led.value_to_percent(avg))

    def joystick_callback(self, pin):
        self.aantal += 1
        print("Er is {} keer op de joystick gedrukt!".format(self.aantal))
        self.status = (self.status + 1) % 3
        self.show_status()

    def read_x(self):
        return self.mcp.read_channel(1)

    def read_y(self):
        return self.mcp.read_channel(0)

    # joystick_message
    def joystick_message(self, direction):
        n = self.read_x() if direction == 'X' else self.read_y()
        text = "VR{0} => {1}".format(direction, n)
        bars = math.floor(n / 1023 * 16)
        return [bars, text]

    # show_status: veranderd het display
    def show_status(self):
        self.lcd.clear_display()
        if self.status == 0:
            ips = check_output(
                ['hostname', '--all-ip-addresses']).split()
            self.lcd.write_message(ips[0].decode())
            if len(ips) > 1:
                self.lcd.set_cursor(1, 0)
                self.lcd.write_message(ips[1].decode())
        else:
            if self.status == 1:
                message = self.joystick_message('X')
            else:
                message = self.joystick_message('Y')
            for i in range(message[0]):
                self.lcd.send_character(219)
            self.lcd.set_cursor(1, 0)
            self.lcd.write_message(message[1])


class LCD:
    def __init__(self, rs, enable, pcf):
        self.rs = rs
        self.enable = enable
        self.pcf = pcf

        # Initialiseer alle GPIO pinnen.
        GPIO.setup(self.rs, GPIO.OUT)
        GPIO.setup(self.enable, GPIO.OUT)

        time.sleep(0.1)
        self.init_LCD()

    # stuur instructie
    def send_instruction(self, value):
        # rs laag: voor instruction
        GPIO.output(self.rs, GPIO.LOW)
        # enable hoog
        GPIO.output(self.enable, GPIO.HIGH)
        self.set_data_bits(value)
        # enable terug laag
        GPIO.output(self.enable, GPIO.LOW)
        time.sleep(0.01)

    # stuur 1 character
    def send_character(self, character):
        # rs hoog: voor data
        GPIO.output(self.rs, GPIO.HIGH)
        # enable hoog
        GPIO.output(self.enable, GPIO.HIGH)
        # data klaarzetten
        self.set_data_bits(character)
        # enable laag
        GPIO.output(self.enable, GPIO.LOW)
        time.sleep(0.01)

    # set_data_bits(value)
    def set_data_bits(self, byte):
        self.pcf.write_outputs(byte)

    # write_message(message).
    def write_message(self, message):
        for char in message[:16]:
            self.send_character(ord(char))
        for char in message[16:]:
            self.move_screen()
            self.send_character(ord(char))

    def clear_display(self):
        self.send_instruction(0b00000001)
        # self.send_instruction(0b00000010)

    # init_LCD()
    def init_LCD(self):
        # set datalengte op 8 bit (= DB4 hoog), 2 lijnen (=DB3), 5x7 display (=DB2).
        self.send_instruction(0b00111000)
        # display on (=DB2), cursor on (=DB1), blinking on (=DB0)
        self.send_instruction(0b00001111)
        # clear display en cursor home (DB0 hoog)
        self.clear_display()

    # set cursor
    def set_cursor(self, row, col):
        byte = row << 6 | col                                   # byte maken
        # byte | 128 want DB7 moet 1 zijn
        self.send_instruction(byte | 128)

    # Scherm verplaatsen
    def move_screen(self):
        self.send_instruction(0b00011000)


class MCP:
    def __init__(self, bus=0, device=0):
        self.spi = spidev.SpiDev()  # spidev init
        # open bus 0, device 0
        self.spi.open(bus, device)
        # klokfrequentie op 100kHz
        self.spi.max_speed_hz = 10 ** 5
        time.sleep(0.01)

    def read_channel(self, ch):
        # commandobyte samenstellen
        channel = ch << 4 | 128
        # list met de 3 te versturen bytes
        bytes_out = [0b00000001, channel, 0b00000000]
        # versturen en 3 bytes terugkrijgen
        bytes_in = self.spi.xfer2(bytes_out)
        # meetwaarde uithalen
        byte1 = bytes_in[1]
        byte2 = bytes_in[2]
        result = byte1 << 8 | byte2

        return result                                           # meetwaarde teruggeven

    def close_spi(self):
        self.spi.close()


class PCF:
    def __init__(self, SDA, SCL, address):
        self.sda = SDA
        self.scl = SCL
        self.__address = address

        # GPIO setup
        self.__setup()

    def write_outputs(self, data: int):
        # data schrijven
        self.__writebyte(data)
        # ack simuleren door 1 bit te writen
        self.__writebit(1)

    @property
    def address(self):
        return self.__address

    # om het adres van het device te wijzigen
    @address.setter
    def address(self, value):
        self.__address = value

    def __setup(self):
        GPIO.setmode(GPIO.BCM)
        GPIO.setup(self.sda, GPIO.OUT)
        GPIO.setup(self.scl, GPIO.OUT)

        time.sleep(0.1)

        # startconditie
        self.__start_conditie()
        # adres doorklokken + RW=0 om te schrijven
        self.__writebyte(self.__address << 1)
        # ack
        self.__ack()

    def __start_conditie(self):
        GPIO.output(self.sda, GPIO.HIGH)
        time.sleep(0.002)
        GPIO.output(self.scl, GPIO.HIGH)
        time.sleep(0.002)
        GPIO.output(self.sda, GPIO.LOW)
        time.sleep(0.002)
        GPIO.output(self.scl, GPIO.LOW)
        time.sleep(0.002)

    def stop_conditie(self):
        GPIO.output(self.scl, GPIO.HIGH)
        time.sleep(0.002)
        GPIO.output(self.sda, GPIO.HIGH)
        time.sleep(0.002)

    def __writebit(self, bit):
        # sda bitwaarde geven
        GPIO.output(self.sda, bit)
        time.sleep(0.002)
        # clock hoog
        GPIO.output(self.scl, GPIO.HIGH)
        time.sleep(0.002)
        # clock laag na 0.002
        GPIO.output(self.scl, GPIO.LOW)
        time.sleep(0.002)

    def __ack(self):
        # setup input + pullup van sda pin
        GPIO.setup(self.sda, GPIO.IN, pull_up_down=GPIO.PUD_UP)
        # klok omhoog brengen
        GPIO.output(self.scl, GPIO.HIGH)
        time.sleep(0.002)
        # sda pin inlezen: laag = OK
        status = GPIO.input(self.sda) == GPIO.LOW
        # setup output van sda pin
        GPIO.setup(self.sda, GPIO.OUT)
        # klok omlaag
        GPIO.output(self.scl, GPIO.LOW)
        time.sleep(0.002)
        return status

    def __writebyte(self, byte):
        # 8 keer een bit schrijven
        mask = 0x80
        for i in range(8):
            self.__writebit(byte & (mask >> i))


class Display:
    def __init__(self, display_knop):
        self.ser = serial.Serial('/dev/serial1')  # open serial port
        time.sleep(0.5)  # wait a bit until serial port is ready
        GPIO.setup(display_knop, GPIO.IN, GPIO.PUD_UP)
        GPIO.add_event_detect(display_knop, GPIO.FALLING,
                              self.display_btn, bouncetime=1000)
        # status: 0 == HH:MM, 1 == 00:SS
        self.status = 0
        self.prev_time = None
        self.t = 0

    def get_time(self):
        return time.strftime("%H%M")

    def get_seconds(self):
        return "00" + time.strftime("%S")

    def send_time(self):
        if self.status == 0:
            # als tijd veranderd is
            if self.get_time() != self.prev_time:
                self.prev_time = self.get_time()
                # stuur tijd
                self.ser.write(self.get_time().encode())
                # response lezen
                print(self.ser.readline().decode().strip('\n'))
        elif self.status == 1:
            if self.t < 5:
                seconds = self.get_seconds()
                if self.prev_time != seconds:
                    self.prev_time = seconds
                    self.ser.write(seconds.encode())
                    print(self.ser.readline().decode().strip('\n'))
                    self.t += 1
            else:
                self.status = 0
                self.t = 0

    def display_btn(self, btn):
        self.status = 1


class PWM_led:
    def __init__(self, pin):
        GPIO.setup(pin, GPIO.OUT)
        self.pwm = GPIO.PWM(pin, 50)
        self.pwm.start(0)  # led uit

    def set_duty_cycle(self, duty):
        self.pwm.ChangeDutyCycle(duty)

    def off(self):
        self.set_duty_cycle(0)

    @staticmethod
    def value_to_percent(value):
        return (value / 1023) * 100

    @staticmethod
    def average(color1, color2):
        return (float(color1 + color2)) / 2


if __name__ == "__main__":
    main = Main(knop_joystick, red, green, blue)
    try:
        main.show_status()
        while True:
            main.change_leds(main.leds)
            main.display.send_time()
    except KeyboardInterrupt:
        print('quitting...')
    finally:
        main.lcd.clear_display()
        main.lcd.pcf.stop_conditie()
        main.display.ser.close()
        main.mcp.close_spi()
        for led in main.leds:
            led.off()
    GPIO.cleanup()
