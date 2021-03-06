//this sketch is just a weird face flying through space 
 //click anywhere to make sparkles
 
 
//maximum number of sparkles to be shown
int maxNumSparkles = 20;
 
//array for the sparkles
Sparkles[] manySparkles = new Sparkles[maxNumSparkles];
Sparkles[] manySparkles1 = new Sparkles[maxNumSparkles];
 
PImage img;
PImage img2;
PImage img3;
int idx = 0;
int idx2 = 0;
 
Comet comets;
 
int savedTime;
int totalTime = 10000;
Timer timer;
 
void setup() {
  //800 by 800 pixels canvas, and all three 'spaceships'
 img = loadImage ("Spaceship 2.jpg"); 
 img2 = loadImage ("nyan cat.jpg");
 img3 = loadImage ("Spaceship 3.jpg");
 size(800,900,P3D);
   
  smooth();
  noStroke();
  comets = new Comet(100,200,50,50,color(200,0,0),10);
   
  float sparkx = random(200,600);
  float sparky = random(200,600);
  for(int f = 0; f < maxNumSparkles; f++) {
      manySparkles1[f] = new Sparkles(sparkx,sparky);
    }
   
  timer = new Timer(10000);
  timer.start();
   
  //Displays 1 frame a second of flashing lights
  //this will help the flashes not be so much
  savedTime = millis();
}
 
void draw() {

  //Refreshes background to black
  background(0);
   
  drawStars();
  
   
  comets.updatePosition();
  comets.drawComet();
   
     
  //Streaks
  stroke(#FFFF00);
  for (int j = 0; j < 3; j++) {
    rect(random(0,400),320,30,1);
  }
   
  for (int j = 0; j < 3; j++) {
    rect(random(0,600),350,30,1);
  }
   
   
   
  pushMatrix();
  translate(300,300);
   
  //Drawing with random color
  float reda = random(1,250);
  float greena = random(1,250);
  float bluea = random(1,250);
  stroke(reda,greena,bluea);
  smooth();
  strokeWeight(3);
   
  drawShip();
   
  popMatrix();
   
  drawJetTrail();
   
  drawStreaks();
   
   
  if (timer.isFinished()) {
    float sparkx = random(200,600);
    float sparky = random(200,600);
    for(int f = 0; f < maxNumSparkles; f++) {
      manySparkles1[f] = new Sparkles(sparkx,sparky);
    }
     
    timer.start();
  }
   
  for (int d = idx2; d < maxNumSparkles; d++) {
    if (manySparkles1[d] != null) {
      manySparkles1[d].display();
      manySparkles1[d].move();
    }
  }
   
  for (int d = idx; d < maxNumSparkles; d++) {
    if (manySparkles[d] != null) {
      manySparkles[d].display();
      manySparkles[d].move();
        image(img,200,50);
        image(img2,650,250, width/10, height/10);
        image(img3,150,450, width/5, height/5);
    }
  }
  
}
 
 
void drawStars() {
  //Drawing stars
  stroke(255);
  for (int i = 0; i < 100; i++) {
 
    point(random(0,800),random(0,900));
  }
}
 
 
 //the 'ship'
void drawShip() {
 fill(20);
 rect(150,40,150,100);
 ellipse(200,75,25,25);
 ellipse(250,75,25,25);
 rect(190,115,75,20);
   
}
 //the fire effect off the ship
void drawJetTrail() {
  //jet trail
    ellipseMode(RADIUS);
    for (int j = 0; j < 10; j++) {
      stroke(150,0,0);
      fill(150,0,0);
      ellipse(random(100,278),random(350,420),15,15);
      stroke(#FFA500);
      fill(#FFA500);
      ellipse(random(100,278),random(350,420),10,10);
    }
}
 
void drawStreaks() {
    stroke(#FFFF00);
    for (int j = 0; j < 3; j++) {
      rect(random(0,600),400,30,1);
    }
     
    for (int j = 0; j < 3; j++) {
      rect(random(0,600),450,30,1);
    }
}
 
void mousePressed() {
  for(int e = 0; e < maxNumSparkles; e++) {
    manySparkles[e] = new Sparkles(mouseX,mouseY);
  }
}
 
class Comet {
    
  // Properties
  int x;
  int y;
  int w;
  int h;
  color c;
  int xSpeed = 5;
  int ySpeed = 5;
  

  Comet(int x,int y,int w,int h, color c, int s) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
  
    this.xSpeed = s;
    this.ySpeed = s;
  
  }
  

  void drawComet() {
    fill(this.c);
    ellipse( this.x, this.y,this.w, this.h);
  }
    
  void updatePosition() {
    if((this.x > width-this.w/2)
    || (this.x < this.w/2)) {
      this.xSpeed = -this.xSpeed;
    }
  
    if((this.y > height-this.h/2)
    || (this.y < this.h/2)) {
      this.ySpeed = -this.ySpeed;
    }
      
    this.x += this.xSpeed;
    this.y += this.ySpeed;
  }
}
 
 
 
//sparkles
class Sparkles{
  float xpos;
  float ypos;
  float spdX;
  float spdY;
  float gravity = .06;
  float colorSegment;
   
  //constructor
  Sparkles(float tempx, float tempy) {
    xpos = tempx;
    ypos = tempy;
 
    spdX = random(-3,3);
 
    spdY = random(-6,-1);
  }
   
  void display() {
    smooth();
    noStroke();
    colorSegment = random(50,255);
    //random Yellow
    fill(colorSegment,colorSegment,0);
    //the sparkle shapes
    beginShape();
    vertex(xpos,ypos-height/60);
    vertex(xpos+width/200,ypos-height/200);
    vertex(xpos+width/60,ypos);
    vertex(xpos+width/200,ypos+height/200);
    vertex(xpos,ypos+height/60);
    vertex(xpos-width/200,ypos+height/200);
    vertex(xpos-width/60,ypos);
    vertex(xpos-width/200,ypos-height/200);
    endShape();
  }
   
  //sparkle movement
  void move() {
    xpos += spdX;
    spdY += gravity;
    ypos += spdY;
  }
}
class Timer {
    
  int startTime;     
  int endTime;      
    
  Timer(int tempEndTime) {
    endTime = tempEndTime;
  }
    
  void start() {
    startTime = millis();
  }
    
  boolean isFinished() {
    int passedTime = millis() - startTime;
    if (passedTime > endTime) {
      return true;
    } else {
      return false;
    }
  }
}
