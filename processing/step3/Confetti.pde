class Confetti extends Particle {

  Confetti(PVector l) {
    super(l);
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
    rect(0,0,5,5);
    popMatrix();
  }
}
