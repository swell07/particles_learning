ParticleSystem ps;

float speed;
float angle;
float distance;

void setup() {
  size(800, 500, P2D);
  ps = new ParticleSystem(new PVector(width/2, 50), 5);
}

void draw() {
  blendMode(ADD);
  background(0);
  if (ps.isFlower && mousecompare()) {
    speed = random(0.01, 1);
    angle = random(360);
    distance = 0.005;
    ps.addFlower(5, random(-0.01, 0.01), random(-0.01, 0.01), distance * cos(radians(angle)), distance * sin(radians(angle)));//random(-0.01, 0.01), random(-0.01, 0.01));
    ps.update();
  } 
  if (ps.isStart || (!mousecompare())) {
    ps.addParticle(5, 0, random(0, 1), random(-0.02, 0.04), random(0.02));//random(-0.01, 0.01));
    ps.update();
    //fs.run();
    //fs.update();
  } else {
    // ps.run();
    // ps.flowerRun();
    ps.update();
  }
}

void mousePressed() {
  ps = new ParticleSystem(new PVector(mouseX, mouseY), 0.1);
  ps.isFlower = true;
  ps.isStart = false;
}

void mouseReleased() {
  ps.isStart = false;
  ps.isFlower = false;
  ps = new ParticleSystem(new PVector(mouseX, mouseY), 0.2);
}

void mouseMoved() {
  ps.isFlower = false;
  ps.isStart = true;
}

boolean mousecompare() {
  if ((mouseX == pmouseX) && (mouseY == pmouseY)) {
    return true;
  } else {
    return false;
  }
}

//------------------CLASS PARTICLE----------------
class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float r;
  float velLim; //limit speed
  // float d;
  color c;
  ArrayList <Particle> particles;

  Particle(PVector l, float _r, float vx, float vy, float ax, float ay) {
    acceleration = new PVector(ax, ay); //new PVector(0, random(-0.05, 0.05));
    velocity = new PVector(vx, vy);
    location = l.get();
    r = _r;
    particles = new ArrayList<Particle>();

    lifespan = 299.0;
    velLim = 5.0;
    c = color(0, random(130)+125, 255);
  }

  void run() {
    //update();
    display();
    velocity.add(acceleration);
    location.add(velocity);
   lifespan -= 2.0;
  }

  // Method to update location
  void update() {   
    float rlim = random(20, 100);
    float dist =  PVector.dist(location, new PVector(mouseX, mouseY));
    if (dist > rlim) {
      velocity.x = velocity.x * -1;
      velocity.y = velocity.y * -1;
    }
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 2.0;
  }
  
  // Method to display
  void display() {
    stroke(0, lifespan);
    strokeWeight(0);
    fill(c, lifespan);
    ellipse(location.x, location.y, r, r);
  }

  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}

class Confetti extends Particle {

  Confetti(PVector l, float _r,float vx, float vy, float ax, float ay) {
    super(l, _r, vx, vy, ax, ay);
    c = color(random(130)+125,0,255);
  }

  void display() {
    rectMode(CENTER);
    fill(c,lifespan);
    stroke(0,lifespan);
    strokeWeight(0);
    pushMatrix();
    translate(location.x,location.y);
    float theta = map(location.x,0,width,0,TWO_PI*2);
    rotate(theta);
    rect(0,0,r,r);
    popMatrix();
  }
}

//--------------ParticleSystem-------------------
class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  boolean isStart;
  boolean isFlower;

  float speed;
  float angle;
  float distance;

  ParticleSystem(PVector location, float r) {
    origin = location.get();   
    particles = new ArrayList<Particle>();
    isStart = false;
    isFlower = false;
  }

  void addParticle(float r, float vx, float vy, float ax, float ay) {
    float r0 = random(1);
    if (r0 < 0.5) { 
      particles.add(new Particle (origin, r, vx, vy, ax, ay));
    } else {
      particles.add(new Confetti (origin, r, vx, vy, ax, ay));
    }
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }

  void addFlower(float r, float vx, float vy, float ax, float ay) {
    float r0 = random(1);
    if (r0 < 0.5) { 
      particles.add(new Particle (origin, r, vx, vy, ax, ay));
    } else {
      particles.add(new Confetti (origin, r, vx, vy, ax, ay));
    }
    for (int i=0; i<particles.size(); i++) {//(int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.display();
      p.update();

      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }

  void update() {
    origin = new PVector(mouseX, mouseY);
  }
}

