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
    if (isFlower == true) {
      speed = random(0.01, 1);
      angle = random(360);
      distance = 0.005;
      vx= random(-0.01, 0.01);
      vy= random(-0.01, 0.01);
      ax = distance * cos(radians(angle)); 
      ay = distance * sin(radians(angle));
    }
    if (isStart == true) {
      vx= 0; 
      vy= random(0, 1);
      ax = random(-0.02, 0.04); 
      ay = random(0.02);
    }
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


  void update() {
    origin = new PVector(mouseX, mouseY);
  }
}
