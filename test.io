int redLight = 10; 
int blueLight = 8; //Note - tied to ULTS1
int yellowLight = 9; //Note - tied to ULTS2 (which we dont use)
int modeButton = 7; //Digital pin for mode switch, Input
int FSEN; //Analog Pin for front light sensor , Input
int BSEN; //Analog Pin for back light sensor , Input
int LMS1 = 2; //Digital Pin for Left Motor Signal 1 , Output
int LMS2 = 3; //Digital Pin for Left Motor Signal 2 , Output
int RMS1 = 4; //Digital Pin for Righr Motor Signal 1 , Output
int RMS2 = 5; //Digital Pin for Right Motor Signal 2 , Output
int ULTS1 = 8; //Digital Pin for Ultrasonic Sensor 1, Input/Output
int ULTS2 = 9; //Digital Pin for Ultrasonic Sensor 2, Input/Output

double duration;
double distance;
double reading,reading2;
void setup() {
  
 pinMode(redLight,OUTPUT);
 pinMode(blueLight,OUTPUT);
 pinMode(yellowLight,OUTPUT);
 pinMode(modeButton,INPUT);
 pinMode(RMS1,OUTPUT);
 pinMode(RMS2,OUTPUT);
 pinMode(LMS1,OUTPUT);
 pinMode(LMS2,OUTPUT);
 Serial.begin(9600);
}

void loop(){
 modeButtonRead();
 reading = detection ();
 reading2 = frontQRDSensor();
 if(reading < 3){
   rightMotorForward();
   leftMotorForward();
 }
 else{
   rightMotorStop();
   leftMotorStop();
 }
}

double detection(void){
  
  pinMode(ULTS1,OUTPUT);
  digitalWrite(ULTS1, LOW);
  delayMicroseconds(2);
  digitalWrite(ULTS1,HIGH);
  delayMicroseconds(5);
  digitalWrite(ULTS1,LOW);
  pinMode(ULTS1,INPUT);
  
  duration = pulseIn(ULTS1,HIGH);
  distance = duration / 74 /2;                                 
  
  if(distance < 3){
    digitalWrite(redLight,HIGH);
    Serial.println("ENGAGE:");
  }
  else if(distance >= 3 ){
    digitalWrite(redLight,LOW);
    Serial.println("SEARCHING");
  }
 return distance;
}

double frontQRDSensor(void){
  FSEN = analogRead(A0);
  Serial.println(FSEN);
  if(FSEN < 800){
    digitalWrite(yellowLight,HIGH);
  }
  else{
    digitalWrite(yellowLight,LOW);
  }
  return FSEN;
}

void modeButtonRead(){
  
  int state = digitalRead(modeButton);
  Serial.println(state);
  if(state == LOW){
    digitalWrite(yellowLight,HIGH);
  }
  else{
    digitalWrite(yellowLight,LOW);
  }
}

void rightMotorForward(){
  
  digitalWrite(RMS1,HIGH);
  digitalWrite(RMS2,LOW);
  
}

void rightMotorStop(){
  digitalWrite(RMS1,LOW);
  digitalWrite(RMS2,LOW);
}

void leftMotorForward(){
  
  digitalWrite(LMS1,LOW);
  digitalWrite(LMS2,HIGH);
  
}

void leftMotorStop(){
  
  digitalWrite(LMS1,LOW);
  digitalWrite(LMS2,LOW);
}
