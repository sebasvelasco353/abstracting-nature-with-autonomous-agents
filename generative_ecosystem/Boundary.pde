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

    // Define the upper/lower/left/right polygon
    PolygonShape sd_upper = new PolygonShape();
    PolygonShape sd_lower = new PolygonShape();
    PolygonShape sd_left = new PolygonShape();
    PolygonShape sd_right = new PolygonShape();

    // We're just a box
    sd_upper.setAsBox(box2d.scalarPixelsToWorld(w_upper/2), box2d.scalarPixelsToWorld(h_upper/2));
    sd_lower.setAsBox(box2d.scalarPixelsToWorld(w_lower/2), box2d.scalarPixelsToWorld(h_lower/2));
    sd_left.setAsBox(box2d.scalarPixelsToWorld(w_left/2), box2d.scalarPixelsToWorld(h_left/2));
    sd_right.setAsBox(box2d.scalarPixelsToWorld(w_right/2), box2d.scalarPixelsToWorld(h_right/2));

    // Create the body
    BodyDef bd_upper = new BodyDef();
    bd_upper.type = BodyType.STATIC;
    bd_upper.position.set(box2d.coordPixelsToWorld(x_upper,y_upper));
    b = box2d.createBody(bd_upper);
    // Attached the shape to the body using a Fixture
    b.createFixture(sd_upper,1);
    b.setUserData(this);

    BodyDef bd_lower = new BodyDef();
    bd_lower.type = BodyType.STATIC;
    bd_lower.position.set(box2d.coordPixelsToWorld(x_lower,y_lower));
    b = box2d.createBody(bd_lower);
    // Attached the shape to the body using a Fixture
    b.createFixture(sd_lower,1);
    b.setUserData(this);

    BodyDef bd_left = new BodyDef();
    bd_left.type = BodyType.STATIC;
    bd_left.position.set(box2d.coordPixelsToWorld(x_left,y_left));
    b = box2d.createBody(bd_left);
    // Attached the shape to the body using a Fixture
    b.createFixture(sd_left,1);
    b.setUserData(this);

    BodyDef bd_right = new BodyDef();
    bd_right.type = BodyType.STATIC;
    bd_right.position.set(box2d.coordPixelsToWorld(x_right,y_right));
    b = box2d.createBody(bd_right);
    // Attached the shape to the body using a Fixture
    b.createFixture(sd_right,1);
    b.setUserData(this);
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

}
