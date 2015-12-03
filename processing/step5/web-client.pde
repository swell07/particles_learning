ParticleSystem ps;

void setup() {
  size($('#touch').width(), $('#touch').height(), P2D);
  int a  = floor(random(3));
  color[][] colors = {
    {color(130, 0, 255), color(255, 0, 255), color(0, 130, 255), color(0, 255, 255)},
    {color(130, 255, 0), color(255, 255, 0), color(0, 255, 130), color(0, 255, 255)},
    {color(255, 130, 0), color(255, 255, 0), color(255, 0, 130), color(255, 0, 255)}
  };
  ps = new ParticleSystem(new PVector(width/2, 50), 5, colors[a]);
  ps.isOver = true;
}

void draw() {
  // blendMode(ADD);
  background(0);
  if (ps) {
    ps.addParticle();
    // ps.updateOrigin();
    ps.updateMouse(ps.mseX,ps.mseY);
  }
}

void mousePressed(){
  ps.isOver = false;
  ps.updateMouse(mouseX, mouseY);
  sendEvent('down',{
    x:mouseX,
    y:mouseY
  })

  //p5
  background(20);
  playnotes('Single_Mode',mouseX,mouseY)
}

void mouseDragged(){
  ps.updateMouse(mouseX, mouseY);
  sendEvent('move',{
    x:mouseX,
    y:mouseY
  })

  //p5
  updatenotes('Single_Mode',mouseX,mouseY)
}

void mouseReleased(){
  ps.updateMouse(mouseX, mouseY);
  ps.isOver = true;
  // ps = null;
  sendEvent('up',{
    x:mouseX,
    y:mouseY
  })
  sendEvents();

  //p5
  background(180);
  stopnotes('Single_Mode',mouseX,mouseY)
}
