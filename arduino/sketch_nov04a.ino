#include <SoftwareSerial.h>
#include <DHT.h>

SoftwareSerial bluetooth(8,7);
#define DHTPIN 2     // what pin we're connected to
#define DHTTYPE DHT22   // DHT 22  (AM2302)
DHT dht(DHTPIN, DHTTYPE); //// Initialize DHT sensor for normal 16mhz Arduino
#define an A0
int chk;
float hum;  //Stores humidity value
float temp; //Stores temperature value
int value = 0, moisture = 0;
void setup() {
      dht.begin();
Serial.begin(9600);
  
  bluetooth.begin(9600);
}

void loop() {
delay(1);

 hum = dht.readHumidity();
 temp = dht.readTemperature();
value = analogRead(an);
  moisture = map(value, 0, 1023, 0, 100); /* value==1017--->0 , 100--->100*/
 Serial.println(hum);
  bluetooth.write('t');
  bluetooth.write(static_cast<byte>(static_cast<int>(hum)));
  bluetooth.write(static_cast<byte>(static_cast<int>(temp)));
  bluetooth.write(static_cast<byte>(static_cast<int>(moisture)));
 delay(5000);
}
