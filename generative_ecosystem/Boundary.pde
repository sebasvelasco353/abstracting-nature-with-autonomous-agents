// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2012
// Box2DProcessing example

// A fixed boundary class

class Boundary {

  // A boundary is a simple rectangle with x,y,width,and height
  float x, x_upper, x_lower, x_left, x_right;
  float y, y_upper, y_lower, y_left, y_right;
  float w, w_upper, w_lower, w_left, w_right;
  float h, h_upper, h_lower, h_left, h_right;

  // But we also have to make a body for box2d to know about it
  Body b;

  Boundary(float x_,float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;

    x_upper = x_;
    y_upper = y_ - (h/2);
    w_upper = w_;
    h_upper = 1;

    x_lower = x_;
    y_lower = y_ + (h/2);
    w_lower = w_upper;
    h_lower = h_upper;

    x_left = x_ - (w/2);
    y_left = y_;
    w_left = 1;
    h_left = h_;

    x_right = x_ + (w/2);
    y_right = y_;
    w_right = 1;
    h_right = h_;

    makeBody(x_upper, y_upper, w_upper, h_upper);
    makeBody(x_lower, y_lower, w_lower, h_lower);
    makeBody(x_left, y_left, w_left, h_left);
    makeBody(x_right, y_right, w_right, h_right);
  }

  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() {
    fill(0);
    stroke(0);
    rectMode(CENTER);
    rect(x_upper,y_upper,w_upper,h_upper);
    rect(x_lower,y_lower,w_lower,h_lower);
    rect(x_left,y_left,w_left,h_left);
    rect(x_right,y_right,w_right,h_right);
  }

  void makeBody(float x, float y, float w, float h) {
    PolygonShape sd = new PolygonShape();
    sd.setAsBox(box2d.scalarPixelsToWorld(w/2), box2d.scalarPixelsToWorld(h/2));

    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    // Attached the shape to the body using a Fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.filter.categoryBits = 0x0004;
    fd.filter.maskBits = 0x0001;
    b.createFixture(fd);
    b.setUserData(this);
  }

}
