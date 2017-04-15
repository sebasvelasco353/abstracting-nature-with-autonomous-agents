// Generative ecosystem
// Template code for Hoy Es Diseno
// based on code by Daniel Shiffman
// by Mick van Olst, onformative

import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;
World world;
Boundary wall;

void setup() {
  size(800,600);
  smooth();
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0,0);
  box2d.listenForCollisions();

  world = new World(20, box2d);
  wall = new Boundary(width/2, height/2, width, height);
}

void draw() {
  background(255);
  box2d.step(); // we always step through time
  world.run();
  wall.display();
}

void mousePressed() {
  world.born(mouseX, mouseY);
}

/* we don't need to do anything with collision events at this moment
// Collision event functions!
void beginContact(Contact cp) {
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  if (o1.getClass() == Attractor.class) {
    Attractor p = (Attractor) o1;
    p.change();

  } else if(o2.getClass() == Attractor.class) {
    Attractor p = (Attractor) o2;
    p.change();
  }

}

// Objects stop touching each other
void endContact(Contact cp) {
}
*/
