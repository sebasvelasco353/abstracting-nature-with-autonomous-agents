// Generative ecosystem
// Template code for Hoy Es Diseño
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
  // box2d.listenForCollisions();

  world = new World(20, box2d);
  wall = new Boundary(width/2, height/2, width, height);
}

void draw() {
  background(10);
  box2d.step(); // we always step through time
  world.run();
  wall.display();
}

void mousePressed() {
  world.bornRandomCreature(new PVector(mouseX, mouseY), box2d);
}
