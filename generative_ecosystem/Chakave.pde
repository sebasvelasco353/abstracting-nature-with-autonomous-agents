class Chakave extends Creature {
  int r;
  float f;

  Chakave(PVector l, Box2DProcessing _box2d) {
    super(l, _box2d);
    r = 20;
    f = map(r, 180, 0, 255, 0);
  }

  void display() {
    //center ellipse
    ellipseMode(CENTER);
    //stroke(250, 250, 250, health);
    fill(0, 0, 0, health);
    Vec2 pos = box2d.getBodyPixelCoord(body);
    ellipse(pos.x, pos.y, r, r);
    
    //wabalalalalalalala
    float scale = 0.5;
    noStroke();
    pushMatrix();
    
    translate(pos.x, pos.y);
    for (float q=30; q>=0; q-=0.5) {
      float r = (6*q+frameCount)%180;
      r = r*scale;
      //float f = map(r, 180, 0, 255, 0);
      f = f*scale;
      fill(int((255-f)*sin(radians(r))), int(255*sin(radians(r))), int(f/2*sin(radians(r))));
  
      for (int i=0; i<360; i+=120) {
        float x = sin(radians(i))*r;
        x = x*scale;
        float y = cos(radians(i))*r;
        y = y*scale;
        float l = sin(radians(3*r-6*frameCount))*r/2*sin(radians(r));
        l = l*scale;
        //float s = 5*sin(radians(r));
        float s = 1;
        pushMatrix();
        translate(x, y);
        rotate(radians(-i));
        if (s > 0) ellipse(l, 0, s, s);
        popMatrix();
      }
    }
    
    popMatrix();

    // here you'll start with your code, you can make your own
    // functions and overwrite the display() function
    // void display() {
    //   displayDebug();
    // }
  }
}