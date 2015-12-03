HashMap users = new HashMap();
float offsetX;

void setup( ) {
  size($('#touch').width(), $('#touch').height(), P2D);
  users = new HashMap();
}

void draw( ) {
  background(0);
  //iteration
  Iterator i = users.entrySet().iterator();  // Get an iterator
  ParticleSystem ps;
  while (i.hasNext()) {
    Map.Entry me = (Map.Entry)i.next();
    // print(me.getKey() + " is ");
    // println(me.getValue());
    ps = (ParticleSystem)me.getValue();
    if (ps){
      ps.addParticle();
      ps.updateMouse(ps.mseX+ offsetX,ps.mseY);
    }
  }
}

void initUser(String keys, float x, float y) {
  ParticleSystem ps = users.get(keys);
  if (!ps){
    char c = keys.charAt(keys.length() - 1);
    int a = c % 3; //0,1,2
    offsetX = random(200)*(a+1);

    color[][] colors = {
    {color(130, 0, 255), color(255, 0, 255), color(0, 130, 255), color(0, 255, 255)},
    {color(130, 255, 0), color(255, 255, 0), color(0, 255, 130), color(0, 255, 255)},
    {color(255, 130, 0), color(255, 255, 0), color(255, 0, 130), color(255, 0, 255)}
  };

    ps = new ParticleSystem(new PVector(width/2, 50), 5, colors[a]);
  }
  ps.isOver = false;
  ps.updateMouse(x + offsetX, y)
  users.put(keys, ps);
}

void updateUser(String keys, float x, float y) {
  ParticleSystem ps = users.get(keys);
  if (ps){
    ps.updateMouse(x + offsetX, y)
    users.put(keys, ps);
  }
}

void delUser(String keys, float x, float y) {
  ParticleSystem ps = users.get(keys);
  if (ps) {
    ps.updateMouse(x + offsetX, y)
    ps.isOver = true;
  }
  users.put(keys, ps);
}
