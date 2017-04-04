import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class generative_ecosystem extends PApplet {

// Generative ecosystem
// Template code for Hoy Es Diseno
// based on code by Daniel Shiffman
// by Mick van Olst, onformative

World world;

public void setup() {
  
  

  world = new World(20);
}

public void draw() {
  world.run();
}

public void mousePressed() {
  world.born(mouseX, mouseY);
}
class Creature {
  PVector location;
  float health;
  float r;

  Creature(PVector l) {
    location = l.get();
    health = 200;
    r = 20;
  }

  public void run() {
    update();
    borders();
    display();
  }

  public void eat(Food f) {
    ArrayList<PVector> food = f.getFood();
    // are we touching any food?
    for(int i = food.size()-1; i >= 0; i--) {
      PVector foodLocation = food.get(i);
      float d = PVector.dist(location, foodLocation);
      // if we are, health goes up
      if(d < r/2) {
        health += 100;
        food.remove(i);
      }
    }
  }

  public void update() {
    health -= 0.2f;
  }

  public void borders() {
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }

  public void display() {
    ellipseMode(CENTER);
    stroke(0, health);
    fill(0, health);
    ellipse(location.x, location.y, r, r);
  }

  public boolean dead() {
    if(health < 0.0f) {
      return true;
    } else {
      return false;
    }
  }
}
class Food {
  ArrayList<PVector> food;

  Food(int num) {
    // Start with some food
    food = new ArrayList();
    for(int i = 0; i < num; i++) {
      food.add(new PVector(random(width), random(height)));
    }
  }

  public void add(PVector l) {
    food.add(l.get());
  }

  public void run() {
    for(PVector f : food) {
      rectMode(CENTER);
      stroke(0);
      fill(175);
      rect(f.x, f.y, 8, 8);
    }

    // There's a small chance food will appear randomly
    if(random(1) < 0.001f) {
      food.add(new PVector(random(width), random(height)));
    }
  }

  public ArrayList getFood() {
    return food;
  }
}
class World {

  ArrayList<Creature> creatures;
  Food food;

  World(int num) {
    food = new Food(num);
    creatures = new ArrayList<Creature>();
    for(int i = 0; i < num; i++) {
      PVector l = new PVector(random(width), random(height));
      creatures.add(new Creature(l));
    }
  }

  public void born(float x, float y) {
    PVector l = new PVector(x,y);
    creatures.add(new Creature(l));
  }

  public void run() {
    food.run();

    for(int i = creatures.size()-1; i >= 0; i--) {
      Creature c = creatures.get(i);
      c.run();
      c.eat(food);

      if(c.dead()) {
        creatures.remove(i);
        food.add(c.location);
      }
    }
  }
}
  public void settings() {  size(800,600);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "generative_ecosystem" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
