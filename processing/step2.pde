// an arrayList of Particles

ArrayList<Particle> particles;

void setup() {
  size(600, 600);
  particles  = new ArrayList<Particle>();
}

void draw() {
  background(0);
  
  particles.add(new Particle(new PVector(mouseX,mouseY)));
  
  // Looping through backwards to delete
  for (int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.run();
    if (p.isDead()) {
      particles.remove(i);
    }
  }
}


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
    //颜色随机必须放在initialise中，不然会闪瞎你！
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
