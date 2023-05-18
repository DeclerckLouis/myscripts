int sensor = 2; //touch sensor on pin 2
int led = 7; // LED on pin 7, can be changed if needed

void setup()
{
  Serial.begin(9600);
  Serial.println("Ready for caregiving, delay set at 300.");
  pinMode(led, OUTPUT);
  pinMode(sensor, INPUT_PULLUP);
  Serial.println("Blinking LED");
  digitalWrite(led, HIGH);
  delay(200);
  digitalWrite(led, LOW);
  delay(200);
  digitalWrite(led, HIGH);
  delay(200);
  digitalWrite(led, LOW);
  delay(200);
  digitalWrite(led, HIGH);
  delay(200);
  digitalWrite(led, LOW);
  delay(200);
  digitalWrite(led, HIGH);
  delay(200);
  digitalWrite(led, LOW);
  delay(200);
  Serial.println("Initialization completed, awaiting input.");
}

void loop()
{
  if (digitalRead(sensor)){ // when sensor is pressed
    Serial.println("YES TOUCH");
    digitalWrite(led, HIGH);
    delay(100);
    digitalWrite(led, LOW);
    delay(100);    
    }
  else {
    Serial.println(".");
    delay(100);
    } 
}
