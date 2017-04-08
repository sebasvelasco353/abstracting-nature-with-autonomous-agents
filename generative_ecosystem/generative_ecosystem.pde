// Generative ecosystem
// Template code for Hoy Es Diseno
// based on code by Daniel Shiffman
// by Mick van Olst, onformative

World world;

void setup() {
  size(800,600);
  smooth();

  world = new World(20);
}

void draw() {
  background(255);
  world.run();
}

void mousePressed() {
  world.born(mouseX, mouseY);
}
