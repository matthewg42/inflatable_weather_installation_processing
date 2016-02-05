import processing.serial.*;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.JSONArray;

/****VALUES TO CHANGE THRESHOLDS****/
//
static int lowDecibelLimit = 30;
int highDecibelLimit = 70;
//
static int lowCO2Limit = 500;
int middleC02Limit = 1500;
int highCO2Limit = 2000;
//
//****VALUES TO CHANGE THRESHOLDS****
//
Serial myPort;

PFont myFont;
static int previousCo2 = lowCO2Limit;
static int previousDec = lowDecibelLimit;

String co2Request;
String decibelRequest;
static long timestamp = 0;
 
void setup() {
  fullScreen();
  background(255, 69, 0);
  //background(50);
  //
  /*
   // Set the proxy server and port to nottingham uni 
   Properties systemSettings = System.getProperties();
   systemSettings.put("http.proxyHost", "mainproxy.nottingham.ac.uk");
   systemSettings.put("http.proxyPort", "8080");
   System.setProperties(systemSettings);
   //
   */
  //JSONObject obj = newJSONObject();
  myFont = createFont("Futura-Medium-48.vlw", 150);
  textFont(myFont);
  //
  String portName = Serial.list()[0];
  println ("port list: " + portName);
  myPort = new Serial(this, portName, 9600);
  decibelRequest = "http://www.timestreams.org.uk/wp-content/plugins/timestreams/2/timestream/id/91?limit=1&desc=true";
  co2Request = "http://www.timestreams.org.uk/wp-content/plugins/timestreams/2/timestream/id/90?limit=1&desc=true";
}

void draw() {
  
  try{
  handleData(co2Request, decibelRequest);
  //handleData(co2Request);
  }catch(Exception e){
   e.printStackTrace(); 
  }
  delay(2000);
}
void handleData(String urlBase1, String urlBase2) {
  //delay (2000);
  String measurement1 = getData(urlBase1);
  Integer measurementInt1 = Integer.parseInt(measurement1);
  String measurement2 = getData(urlBase2);
  Integer measurementInt2 = Integer.parseInt(measurement2);
  //println ("decibels: " + decibelInt);
  if ((measurementInt1 == null) || (measurementInt1<=0)) {
    measurementInt1 = previousCo2;
  }
  if ((measurementInt2 == null) || (measurementInt2<=0)) {
    measurementInt2 = previousDec;
  }
  sendSerial(measurementInt1, measurementInt2);
  displayValues(measurementInt1, measurementInt2);
  previousDec = measurementInt2;
  previousCo2 = measurementInt1;
}
String getData(String urlBase) {
  try{
  String request = urlBase + "?last=" + timestamp;
  //println ("url: " + co2Request);

  String timeString = "http://activeingredient.timestreams.org/wp-content/plugins/timestreams/2/time";
  String time = loadStrings(timeString)[0];
  timestamp = parseTime(time);
  String data [] = loadStrings(request);
  //println("data.length: " + data.length); 
  //println("measurement: " + parseMeasurements(data[0]));
  return parseMeasurements(data[0]);
  }catch (NullPointerException npe){
   //npe.printStackTrace(); 
   return "0";
  }
}
String parseMeasurements(String s) {
  println("s: " + s);
  JSONObject obj=(JSONObject)JSONValue.parse(s);

  JSONArray t = (JSONArray)obj.get("measurements");
  int tSize = t.size();
  //println(tSize);
  if (tSize!=0) {
    obj = (JSONObject) t.get(tSize-1);
    return (String)obj.get("value");
  } 
  return "0";
}

long parseTime(String time) {
  String timeString = "http://activeingredient.timestreams.wp.horizon.ac.uk/wp-content/plugins/timestreams/2/time";
  String s = loadStrings(timeString)[0];
  JSONObject obj=(JSONObject)JSONValue.parse(s);

  JSONArray t = (JSONArray)obj.get("timestamp");
  obj = (JSONObject) t.get(0);
  return (Long)obj.get("CURRENT_TIMESTAMP");
}
void sendSerial(int co2, int db) {
  //CO2 thresholds

  //LOWEST CO2
  if (co2<lowCO2Limit) {
    if (db<lowDecibelLimit) {
      myPort.write ('A');
      println("A");
    }
    else if ((db>=lowDecibelLimit)&&(db<highDecibelLimit)) {
      myPort.write('B');
      println("B");
    }
    else if (db>=highDecibelLimit) {
      myPort.write('C');
      println("C");
    }
  }
  //LOW CO2
  if ((co2>=lowCO2Limit)&&(co2<middleC02Limit)) {
    if (db<lowDecibelLimit) {
      myPort.write ('D');
      println("D");
    }
    else if ((db>=lowDecibelLimit)&&(db<highDecibelLimit)) {
      myPort.write('E');
      println("E");
    }
    else if (db>=highDecibelLimit) {
      myPort.write('F');
      println("F");
    }
  }
  //MEDIUM CO2
  if ((co2>=middleC02Limit)&&(co2< highCO2Limit)) {
    if (db<lowDecibelLimit) {
      myPort.write ('G');
      println("G");
    }
    else if ((db>=lowDecibelLimit)&&(db<highDecibelLimit)) {
      myPort.write('H');
      println("H");
    }
    else if (db>=highDecibelLimit) {
      myPort.write('I');
      println("I");
    }
  }
  //HIGH CO2
  if (co2>=highCO2Limit) {
    if (db<lowDecibelLimit) {
      myPort.write ('J');
      println("J");
    }
    else if ((db>=lowDecibelLimit)&&(db<highDecibelLimit)) {
      myPort.write('K');
      println("K");
    }
    else if (db>=highDecibelLimit) {
      myPort.write('L');
      println("L");
    }
  }
}


void displayValues(int co2, int db) {
  background(255, 69, 0);

  String displayC02Text = (co2 +" C02 (PPM)");
  String displayDecibelText = (db + " DECIBELS");
  text (displayC02Text, width/8, 350);
  text (displayDecibelText, width/8, 600);
  textAlign(LEFT);
}
