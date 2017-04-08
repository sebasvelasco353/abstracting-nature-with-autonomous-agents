// Generative ecosystem
// Template code for Hoy Es Diseno
// based on code by Daniel Shiffman
// by Mick van Olst, onformative

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;
World world;

void setup() {
  size(800,600);
  smooth();
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0,0);

  world = new World(20, box2d);
}

void draw() {
  background(255);
  box2d.step(); // we always step through time
  world.run();
}

void mousePressed() {
  world.born(mouseX, mouseY);
}
