/*
  Serial Call and Response
 Language: Wiring/Arduino

 This program sends an ASCII A (byte of value 65) on startup
 and repeats that until it gets some data in.
 Then it waits for a byte in the serial port, and
 sends three sensor values whenever it gets a byte in.

 Thanks to Greg Shakar and Scott Fitzgerald for the improvements

   The circuit:
 * potentiometers attached to analog inputs 0 and 1
 * pushbutton attached to digital I/O 2

 Created 26 Sept. 2005
 by Tom Igoe
 modified 24 April 2012
 by Tom Igoe and Scott Fitzgerald

 This example code is in the public domain.

 http://www.arduino.cc/en/Tutorial/SerialCallResponse

 */
int numPixels = 100;
byte data[512];

void setup() {
  // start serial port at 9600 bps:
  Serial.begin(115200);
  calibration();
}

void loop() {
  rainbow();
}

void calibration(){
  uint16_t i, j;
  
  for(i=0; i<numPixels; i++) {
    data[i*3 + 0] = 255;
    data[i*3 + 1] = 0;
    data[i*3 + 2] = 0;
  }

  for(j=0; j < 500; j++){
    Serial.write(data, 512);
    delay(10);
  }
}


void rainbow() {
  uint16_t i, j;

  for(j=0; j<256; j++) {
    for(i=0; i<numPixels; i++) {
      data[i*3 + 0] = WheelR((i+j) & 255);
      data[i*3 + 1] = WheelG((i+j) & 255);
      data[i*3 + 2] = WheelB((i+j) & 255);
    }
    Serial.write(data, 512);
    delay(10);
  }
}

byte WheelR(byte WheelPos) {
  WheelPos = 255 - WheelPos;
  if(WheelPos < 85) {
   return (255 - WheelPos * 3);
  } else if(WheelPos < 170) {
    WheelPos -= 85;
   return 0;
  } else {
   WheelPos -= 170;
   return (WheelPos * 3);
  }
}

byte WheelG(byte WheelPos) {
  WheelPos = 255 - WheelPos;
  if(WheelPos < 85) {
   return 0;
  } else if(WheelPos < 170) {
    WheelPos -= 85;
   return (WheelPos * 3);
  } else {
   WheelPos -= 170;
   return (255 - WheelPos * 3);
  }
}

byte WheelB(byte WheelPos) {
  WheelPos = 255 - WheelPos;
  if(WheelPos < 85) {
   return (WheelPos * 3);
  } else if(WheelPos < 170) {
    WheelPos -= 85;
   return (255 - WheelPos * 3);
  } else {
   WheelPos -= 170;
   return (0);
  }
}

