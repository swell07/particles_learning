class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  color c;

  Particle(PVector l) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-0.5, 0.5), random(-1, 0));
    location = l.get();
    lifespan = 255.0;
    c = color(0,random(130)+125,255);
  }

  void run() {
    update();
    display();
  }

  // Method to update location
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 2.0;
  }

  // Method to display
  void display() {
    stroke(0, lifespan);
    strokeWeight(0);
    fill(c, lifespan);
    ellipse(location.x, location.y, 5, 5);
  }
  
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
