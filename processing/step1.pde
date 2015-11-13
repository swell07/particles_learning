// what is a particle?

Particle p;
void setup() {
  size(600, 600);
  p  = new Particle(new PVector(width/2, 50));
}

void draw() {
  background(255);
  p.run();
  if (p.isDead()) {
    println("Particle is dead!");
     p  = new Particle(new PVector(mouseX, mouseY));
  }
}

class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-3, 0));
    location = l.get();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

//motion
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 2.0;
  }

  void display() {
    float theta = map(location.x,0,width,0,TWO_PI*2);
    rectMode(CENTER);
    
    stroke(0, lifespan);
    fill(0, lifespan);
    //ellipse(location.x, location.y, 8, 8);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    ellipse(0,0,8,8);
    popMatrix();
  }

  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
