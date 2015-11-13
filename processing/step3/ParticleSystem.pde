class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  boolean isStart;

  ParticleSystem(PVector location) {
    origin = location.get();
    isStart = false;
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    //if (isStart == true) {
      float r = random(1);
      if (r < 0.5) { 
        particles.add(new Particle(origin));
      } else {
        particles.add(new Confetti(origin));
      }
    //}
  }

  void update() {
    origin = new PVector(mouseX, mouseY);
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {

      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}
