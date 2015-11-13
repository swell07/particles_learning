ParticleSystem ps;

void setup() {
  size(640, 360, P2D);
  ps = new ParticleSystem(new PVector(width/2, 50));
}

void draw() {
  blendMode(ADD);
  background(0);
  if (ps.isStart == true) {
    ps.addParticle();
    ps.run();
    ps.update();
  }
}

void mousePressed() {
  ps = new ParticleSystem(new PVector(mouseX, mouseY));
  ps.isStart = true;
}

void mouseReleased() {
  ps.isStart = false;
}
