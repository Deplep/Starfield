Particle[] particles = new Particle[200]; 
int explosionCount = 0;                   // Track the number of particles per explosion
Boxes[] boxes = new Boxes[200];          // Array to hold boxes
specialBox[] specialBoxes = new specialBox[1]; // Corrected size to match `boxes`

void setup(){
  size(1000, 1000);
  background(0);
  
  // Initialize regular boxes
  for (int i = 0; i < boxes.length; i++) {
    boxes[i] = new Boxes((int)(Math.random()*1000), (int)(Math.random()*1000));
  }
  
  // Initialize special boxes at the same locations as the boxes
  for (int i = 0; i < specialBoxes.length; i++) {
    specialBoxes[i] = new specialBox((int)(Math.random()*1000), (int)(Math.random()*1000));
  }
}

void draw(){
  background(0);
  
  // Display and move particles
  for (int i = 0; i < explosionCount; i++) {
    particles[i].move();
    particles[i].show();
  }
  
  // Display regular boxes
  for (int i = 0; i < boxes.length; i++) {
    boxes[i].show();
  }
  
  // Display special boxes (with specific red color)
  for (int i = 0; i < specialBoxes.length; i++) {
    fill(255, 0, 0);  // Red color for specialBox
    specialBoxes[i].show();
  }
}

void mousePressed(){
  explosionCount = 0;
  
  // Check if any regular box is clicked
  for (int i = 0; i < boxes.length; i++) {
    if (boxes[i].isClicked(mouseX, mouseY)) {
      boxes[i].isVisible = false; // Hide the box if clicked
      
      // Initialize particles for explosion at clicked position
      for (int j = 0; j < particles.length; j++) {
        particles[j] = new Particle(mouseX, mouseY);
        explosionCount++;
      }
    }
  }
  
  // Optionally check if any special box is clicked
  for (int i = 0; i < specialBoxes.length; i++) {
    if (specialBoxes[i].isClicked(mouseX, mouseY)) {
      specialBoxes[i].isVisible = false; // Hide the special box if clicked
      // Optionally trigger a special effect for the special box
    }
  }
}

class Boxes {
  float myX, myY;
  boolean isVisible = true;

  Boxes(float x, float y) {
    myX = x;
    myY = y;
  }

  void show() {
    if (isVisible) {
      fill(255);
      ellipse(myX, myY, 10, 10);
    }
  }

  boolean isClicked(float x, float y) {
    // Check if mouse is within the box's area
    float distance = dist(x, y, myX, myY);
    return isVisible && distance < 5; // 5 is the radius of the dot
  }
}

class specialBox extends Boxes {
  specialBox(float x, float y) {
    super(x, y);
  }

  @Override
  void show() {
    if (isVisible) {
      fill(255, 0, 0); // Special color for special box (red)
      ellipse(myX, myY, 20, 20); // Larger size
    }
  }
}

class Particle {
  double x, y, speed, angle;
  int Color1, Color2, Color3, lifespan;

  Particle(float Xmouse, float Ymouse) {
    x = Xmouse;
    y = Ymouse;
    speed = (int)(Math.random()*30 + 3);
    angle = (Math.random()*TWO_PI);
    Color1 = ((int)(Math.random()*255));
    Color2 = ((int)(Math.random()*255));
    Color3 = ((int)(Math.random()*255));
    lifespan = 255;  //opacity
  }

  void move() {
    x += cos((float)angle) * speed;
    y += sin((float)angle) * speed;
    lifespan -= 5;
  }

  void show() {
    fill(Color1, Color2, Color3, lifespan);
    noStroke();
    ellipse((float)x, (float)y, 10, 10);
  }
}
