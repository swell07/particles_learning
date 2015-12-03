//---------CLASS PARTICLE------
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
  boolean isFlowerRun;
  float X;
  float Y;


  Particle(PVector l, float _r, color _c float vx, float vy, float ax, float ay, boolean isFRun, ParticleSystem ps) {
    acceleration = new PVector(ax, ay); //new PVector(0, random(-0.05, 0.05));
    velocity = new PVector(vx, vy);
    location = l.get();
    r = _r*random(5);
    particles = new ArrayList<Particle>();
    isFlowerRun = isFRun;

    lifespan = 299.0;
    velLim = 5.0;
    c = _c;
    X = ps.mseX;
    Y = ps.mseY;
  }

  void run(){
      if (isFlowerRun){
        flowerRun();
      }else{
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
    lifespan -= 1.0;
    //display();
    stroke(0, lifespan);
    strokeWeight(0);
    fill(c, lifespan);
    ellipse(location.x, location.y, r, r);
  }

  // Method to update location
  void normalRun() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 1.0;
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


//---------------CLASS PS------------------
class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  float r = 5;
  float speed, angle, distance, vx, vy, ax, ay;
  color [] colors;

  boolean isStart;
  boolean isFlower;
  boolean isOver;

  float mseX, mseY, prevMseX, prevMseY;

  ParticleSystem(PVector location, float r, color[] _colors)  {
    origin = location.get();
    particles = new ArrayList<Particle>();
    isStart = false;
    isFlower = false;
    isOver = false;
    colors = _colors;
  }

  void addParticle() {
    if (!isOver){
      ParticleSystem self = (ParticleSystem)this;
      if ( compareMouse() ) {
        speed = random(0.01, 1);
        angle = random(360);
        distance = 0.05 * mseX/width;
        vx = random(-0.01, 0.01);
        vy = random(-0.01, 0.01);
        ax = distance * cos(radians(angle));
        ay = distance * sin(radians(angle));
        float r0 = random(1);
        color colorchange;
        if (r0 < 0.5) {
          colorchange = lerpColor(colors[0], colors[1], random(1));
        }else{
          colorchange = lerpColor(colors[2], colors[3], random(1));
        }
        particles.add(new Particle (origin, r, c, vx, vy, ax, ay, true, self));
      }
      if (!(compareMouse())) {
        vx= 0;
        vy= random(0, 1);
        ax = random(-0.02, 0.04);
        ay = random(0.1);
        float r0 = random(1);
        color colorchange;
        if (r0 < 0.5) {
          colorchange = lerpColor(colors[0], colors[1], random(1));
        }else{
          colorchange = lerpColor(colors[2], colors[3], random(1));
        }
      particles.add(new Particle (origin, r, colorchange, vx, vy, ax, ay, false, self));
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

  void updateOrigin(){
    origin = new PVector(mseX, mseY);
  }

  void updateMouse(float x, float y) {
    prevMseX = mseX;
    prevMseY = mseY;
    mseX = x;
    mseY = y;
    updateOrigin();
  }

  boolean compareMouse() {
    if ((mseX == prevMseX) && (mseY == prevMseY)) {
      return true;
    } else {
      //mseX = prevMseX;
      //mseY = prevMseY;
      return false;
    }
  }

  void destory(){
    isOver = true;
  }
}
