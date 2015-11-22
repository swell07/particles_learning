ParticleSystem ps;

float speed;
float angle;
float distance;

boolean isStart;
boolean isFlower;

void setup() {
  size(800, 500, P2D);
  ps = new ParticleSystem(new PVector(width/2, 50), 5);
}

void draw() {
  blendMode(ADD);
  background(0);
  ps.addParticle();
  ps.update();
  println(mousecompare());
}

boolean mousecompare() {
  if ((mouseX == pmouseX) && (mouseY == pmouseY)) {
    return true;
  } else {
    return false;
  }
}

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


  void flowerRun() {
    float rlim = random(20, 100);
    float dist =  PVector.dist(location, new PVector(mouseX, mouseY));
    if (dist > rlim) {
      velocity.x = velocity.x * -1;
      velocity.y = velocity.y * -1;
    }
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 2.0;
    //display();
    stroke(0, lifespan);
    strokeWeight(0);
    fill(c, lifespan);
    ellipse(location.x, location.y, r, r);
  }

  // Method to update location
  void update() {   
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 2.0;
    //display();
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

  Confetti(PVector l, float _r, float vx, float vy, float ax, float ay) {
    super(l, _r, vx, vy, ax, ay);
    c = color(random(130)+125, 0, 255);
  }

  void display() {
    rectMode(CENTER);
    fill(c, lifespan);
    stroke(0, lifespan);
    strokeWeight(0);
    pushMatrix();
    translate(location.x, location.y);
    float theta = map(location.x, 0, width, 0, TWO_PI*2);
    rotate(theta);
    rect(0, 0, r, r);
    popMatrix();
  }
}

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  float r = 5;
  float speed, angle, distance, vx, vy, ax, ay;

  boolean isStart;
  boolean isFlower;

  ParticleSystem(PVector location, float r) {
    origin = location.get();   
    particles = new ArrayList<Particle>();
    isStart = false;
    isFlower = false;
  }

  void addParticle() {
    if ( mousecompare()) {
      speed = random(0.01, 1);
      angle = random(360);
      distance = 0.05 * mouseX/width; 
      vx= random(-0.01, 0.01);
      vy= random(-0.01, 0.01);
      ax = distance * cos(radians(angle)); 
      ay = distance * sin(radians(angle));
      particles.add(new Particle (origin, r, vx, vy, ax, ay));
      for (int i = particles.size()-1; i >= 0; i--) {
        Particle p = particles.get(i);
        p.flowerRun();
        if (p.isDead()) {
          particles.remove(i);
        }
      }
    }
    if (!(mousecompare())) {
      vx= 0; 
      vy= random(0, 1);
      ax = random(-0.02, 0.04); 
      ay = random(0.1);
      particles.add(new Confetti (origin, r, vx, vy, ax, ay));
      for (int i = particles.size()-1; i >= 0; i--) {
        Particle p = particles.get(i);
        p.update();
        if (p.isDead()) {
          particles.remove(i);
        }
      }
    }
  }


  void update() {
    origin = new PVector(mouseX, mouseY);
  }
}
