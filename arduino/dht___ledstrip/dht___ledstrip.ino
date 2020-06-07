#include "RGBdriver.h"
#include <DHT.h>;

#define CLK 3       
#define DIO 2
RGBdriver Driver(CLK,DIO);

#define DHTPIN 7     // what pin we're connected to
#define DHTTYPE DHT22   // DHT 22  (AM2302)
DHT dht(DHTPIN, DHTTYPE); //// Initialize DHT sensor for normal 16mhz Arduino

int chk;
float hum;  //Stores humidity value
float temp; //Stores temperature value

String bericht;

void setup()  
{ 
Serial.begin(9600);
Serial.setTimeout(100);
bericht = "0";
dht.begin();
}  
void loop()  
{ 
  if (Serial.available() > 0) {
    //Serial.println("bekijk");
    bericht = Serial.readString();
    //Serial.println(bericht);
  }
  bericht.trim();
  if (bericht == "m"){
    Serial.println("maanlicht");
    Driver.begin();
     Driver.SetColor(10, 10, 10);
    Driver.end();
  } else {
  if (bericht == "z") {
    Serial.println("zonlicht");
    Driver.begin();
    Driver.SetColor(200, 155, 122);
    Driver.end();
  } else {
  if (bericht == "u") {
    Serial.println("uit");
    Driver.begin();
    Driver.SetColor(0, 0, 0);
    Driver.end();
  } else {
  if (bericht == "dht") {
    hum = dht.readHumidity();
    temp= dht.readTemperature();
    Serial.print(hum);
    Serial.print(" ");
    Serial.println(temp);
  } else {
  }}
  }}
  bericht = "0";
}
