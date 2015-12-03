ParticleSystem ps;

boolean isStart;
boolean isFlower;

void setup() {
  fullScreen();
  //size(800, 500, P2D);
  color[][] colors = {
    {color(130, 0, 255), color(255, 0, 255), color(0, 130, 255), color(0, 255, 255)}, 
    {color(130, 255, 0), color(255, 255, 0), color(0, 255, 130), color(0, 255, 255)}, 
    {color(255, 130, 0), color(255, 255, 0), color(255, 0, 130), color(255, 0, 255)}
  };
  int a = floor(random(3));
  ps = new ParticleSystem(new PVector(width/2, 50), 5, colors[a]);
  println(a);
}

void draw() {
  //blendMode(ADD);
  background(0);
  ps.mouseupdate(mouseX, mouseY);
  ps.addParticle();
  ps.update();
  //println(mousecompare());
}

boolean mousecompare() {
  if ((mouseX == pmouseX) && (mouseY == pmouseY)) {
    return true;
  } else {
    return false;
  }
}

//---------CLASS PARTICLE------
class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float r, rLim; //limit radius
  float velLim; //limit speed
  color c;
  ArrayList <Particle> particles;
  boolean isFlowerRun;
  float X;
  float Y;

  Particle(PVector l, float _r, color _c, float vx, float vy, float ax, float ay, boolean isFRun) {
    acceleration = new PVector(ax, ay); //new PVector(0, random(-0.05, 0.05));
    velocity = new PVector(vx, vy);
    location = l.get();
    r = _r;
    particles = new ArrayList<Particle>();
    isFlowerRun = isFRun;

    lifespan = 299.0;
    velLim = 5.0;
    rLim = 20.0;
    c = _c;//color(0, random(130)+125, 255);
    X = mouseX;
    Y = mouseY;
  }

  void run() {
    if (isFlowerRun) {
      flowerRun();
    } else {
      normalRun();
    }
  } 

  void flowerRun() {
    float rlim = random(20, 100);
    float dist =  PVector.dist(location, new PVector(X, Y));
    if (dist > rlim) {
      velocity.x = velocity.x * -1;
      velocity.y = velocity.y * -1;
    }
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 2.0;
    noStroke();
    //stroke(0, lifespan);
    //strokeWeight(0);
    fill(c, lifespan);
    ellipse(location.x, location.y, r, r);
    r+=0.1;
    if (r > rLim) {
      r = rLim;
    }
  }

  // Method to update location
  void normalRun() {   
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 2.0;
    //display();
    noStroke();
    //stroke(0, lifespan);
    //strokeWeight(0);
    fill(c, lifespan);
    ellipse(location.x, location.y, r, r);
    r+=0.1;
    if (r > rLim) {
      r = rLim;
    }
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

  Confetti(PVector l, float _r, color _c, float vx, float vy, float ax, float ay) {
    super(l, _r, _c, vx, vy, ax, ay, false);
    c = _c;//color(random(130)+125, 0, 255);
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

//---------------CLASS PS------------------
class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  color [] colors;

  float r = 5;
  float speed, angle, distance, vx, vy, ax, ay, mx, my;

  boolean isStart;
  boolean isFlower;

  ParticleSystem(PVector location, float r, color [] _colors) {
    origin = location.get();
    particles = new ArrayList<Particle>();
    isStart = false;
    isFlower = false;
    colors = _colors;
  }

  void mouseupdate(float _mx, float _my) {
    mx = _mx;
    my = _my;
  }

  void addParticle() {
    if ( mousecompare()) {
      speed = random(0.01, 1);
      angle = random(360);
      distance = 0.1 * mx/width; 
      vx= random(-0.05, 0.05);
      vy= random(-0.03, 0.03);
      ax = distance * cos(radians(angle)); 
      ay = distance * sin(radians(angle));
      float r0 = random(1);
      if (r0<0.5) {
        color c = lerpColor(colors[0], colors[1], random(1));
        particles.add(new Particle (origin, r, c, vx, vy, ax, ay, true));
      } else {
         color c = lerpColor(colors[2], colors[3], random(1));
        particles.add(new Particle (origin, r, c, vx, vy, ax, ay, true));
      }
    }
    if (!(mousecompare())) {
      vx= 0; 
      vy= random(0, 1);
      ax = random(-0.02, 0.04); 
      ay = random(0.1);
      float r0 = random(1);
      if (r0<0.5) {
        color c = lerpColor(colors[0], colors[1], random(1));
        particles.add(new Particle (origin, r, c, vx, vy, ax, ay, false));
      } else {
         color c = lerpColor(colors[2], colors[3], random(1));
        particles.add(new Particle (origin, r, c, vx, vy, ax, ay, false));
      }
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
    origin = new PVector(mx, my);
  }
}
