// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2011
// Box2DProcessing example

// Showing how to use applyForce() with box2d

// Fixed Attractor (this is redundant with Mover)

class Attractor {

  // We need to keep track of a Body and a radius
  Body body;
  float r;
  color col;

  Attractor(float r_, float x, float y) {
    r = r_;
    // Define a body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;

    // Set its position
    bd.position = box2d.coordPixelsToWorld(x,y);
    body = box2d.world.createBody(bd);

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.filter.categoryBits = 0x0001;
    fd.filter.maskBits = 0x0004;

    body.createFixture(fd);
    body.setUserData(this);
    col = color(255);
  }


  // Formula for gravitational attraction
  // We are computing this in "world" coordinates
  // No need to convert to pixels and back
  Vec2 attract(Creature c) {
    float G = 100; // Strength of force
    // clone() makes us a copy
    Vec2 pos = body.getWorldCenter();
    Vec2 moverPos = c.body.getWorldCenter();
    // Vector pointing from mover to attractor
    Vec2 force = pos.sub(moverPos);
    float distance = force.length();
    // Keep force within bounds
    distance = constrain(distance,1,5);
    force.normalize();
    // Note the attractor's mass is 0 because it's fixed so can't use that
    float strength = (G * 1 * c.body.m_mass) / (distance * distance); // Calculate gravitional force magnitude
    force.mulLocal(strength);         // Get force vector --> magnitude * direction
    return force;
  }

  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(a);
    fill(col);
    noStroke();
    ellipse(0,0,r*2,r*2);
    popMatrix();
  }

  // Change color when hit
  void change() {
    col = color(255, 0, 0);
  }

  PVector getPosition() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    PVector p = new PVector(pos.x, pos.y);
    return p;
  }
}
