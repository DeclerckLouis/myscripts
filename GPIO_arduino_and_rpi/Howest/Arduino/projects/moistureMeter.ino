/* This code is my adaptation of what i found on https://arduinogetstarted.com/tutorials/arduino-soil-moisture-sensor
 * This prototype is supposed to check moisture levels of the soil, and notify the user when the levels are too low (LED)
 * There are a lot of Serial.println's in this code, they are there for debugging purposes, and can be removed if desired
 * The code is not perfect, but it works, and that's all that matters
 */

const int delayValue = 100; // Can be changed if desired, personally, i don't see the point but go off
const int wet = 184; // When soaked in water ## this value is based on my sensor
const int dry = 500; // When dry ## this value is based on my sensor

int blueLED = 7; // LED pin

void setup() {
  Serial.begin(9600);
  Serial.println("Ready for caregiving, delay set at " + String(delayValue));
  pinMode(blueLED, OUTPUT);
  Serial.println("Blinking LED"); // Blink LED to show that the program is ready
  blinkLED(blueLED);
  blinkLED(blueLED);
  }

void loop() {
  int moistValue = analogRead(A0); // Read analog sensor value ## i think this actually shows how many V A0 is getting?
  int moistPercent = map(moistValue, wet, dry, 100, 0); //convert sensor value to percentage :) 
  Serial.println("Current moisture percentage: " + String(moistPercent) + "%");

  if (moistPercent < 30) {
    Serial.println("Soil TOO DRY"); // If the soil is too dry, notify the user
    digitalWrite(blueLED, HIGH);
    }
  else if (moistPercent > 80) {
    Serial.println("soil TOO WET"); // If the soil is too wet, notify the user
    blinkLED(blueLED); // this line can be commented out if the blinking is too annoying (just put less water dumbass)
    }

  else {
    Serial.println("soil JUST GOOD"); // Dont's do anything
    }
  
  delay(delayValue);
  digitalWrite(blueLED, LOW); // Ensure LED is off when the program finishes, or when ELSE is triggered
}

void blinkLED(int led) { // Simple blink function, made it shorter so it's shorter, no problem since it's called every loop if the soil is too wet
  digitalWrite(led, HIGH);
  delay(200);
  digitalWrite(led, LOW);
  delay(200);
  digitalWrite(led, HIGH);
  delay(200);
  }