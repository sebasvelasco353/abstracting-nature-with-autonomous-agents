class Creature {
  PVector loc; // location
  PVector tar; // target
  PVector vel; // velocity
  PVector acc; // acceleration
  float maxforce; // maximum steering force
  float maxspeed; // maximum speed
  float health;
  float r;

  Creature(PVector l) {
    loc = l.get();
    vel = new PVector(0,-2);
    acc = new PVector(0,0);
    maxspeed = 0.5;
    maxforce = 0.005;
    health = 200;
    r = 20;
  }

  void run() {
    update();
    borders();
    display();
  }

  void eat(Food f) {
    ArrayList<PVector> food = f.getFood();
    // are we touching any food?
    for(int i = food.size()-1; i >= 0; i--) {
      PVector foodLocation = food.get(i);
      float d = PVector.dist(loc, foodLocation);
      // if we are, health goes up
      if(d < r/2) {
        health += 100;
        food.remove(i);
      }
    }
  }

  void update() {
    vel.add(acc); // update velocity
    vel.limit(maxspeed); // limit speed
    loc.add(vel);
    acc.mult(0); // reset the acceleration each cycle

    // death is always near
    health -= 0.2;
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acc.add(force);
  }

  void seek(Food f) {
    // first we'll need our list of food locations
    ArrayList<PVector> food = f.getFood();

    if(food.size() >= 1) {
      // we'll go to the closest one
      int closestFoodIndex = 0;
      for(int i = food.size()-1; i > 0; i--) {
        PVector foodLocation = food.get(i);
        // if the distance to our previous closest food is more than the current one we overwrite the index
        if( PVector.dist(loc, food.get(closestFoodIndex)) >= PVector.dist(loc, food.get(i)) ) {
          closestFoodIndex = i;
        }
      }
      tar = food.get(closestFoodIndex);
    } else {
      // hm, no food, lets check if we are already close to our target
      if( PVector.dist(loc, tar) >= 50) {
        // yeah we've likely touched our target, lets pick a random new target
        tar.x = random(width);
        tar.y = random(height);
      }
    }

    // lets apply some force to our target
    PVector desired = PVector.sub(tar, loc); // we get a vector that points from the location to the target
    desired.normalize();
    desired.mult(maxspeed);
    // steer = desired minus velocity
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxforce);
    applyForce(steer);
  }

  void borders() {
    if (loc.x < -r) loc.x = width+r;
    if (loc.y < -r) loc.y = height+r;
    if (loc.x > width+r) loc.x = -r;
    if (loc.y > height+r) loc.y = -r;
  }

  void display() {
    ellipseMode(CENTER);
    stroke(0,0,0, health);
    fill(0,0,0, health);
    ellipse(loc.x, loc.y, r, r);
  }

  boolean dead() {
    if(health < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
