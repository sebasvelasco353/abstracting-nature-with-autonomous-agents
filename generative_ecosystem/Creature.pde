class Creature {
  PVector tar; // target
  float health;
  float r;
  Box2DProcessing box2d;
  Body body;

  Creature(PVector l, Box2DProcessing _box2d) {
    r = 20;
    health = 200;

    box2d = _box2d;
    // lets define a body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    // lets set its position
    bd.position = box2d.coordPixelsToWorld(l.x, l.y);
    body = box2d.world.createBody(bd);
    // lets make it a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);

    // lets define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // parameters that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    body.createFixture(fd);
    body.setUserData(this);

    body.setLinearVelocity(new Vec2(random(-5,5),random(-5,-5)));
    body.setAngularVelocity(random(-1,1));
  }

  void run() {
    update();
    borders();
    display();
  }

  void eat(Food f) {
    ArrayList<Attractor> food = f.getFood();
    Vec2 vecLoc = box2d.getBodyPixelCoord(body);
    PVector loc = new PVector(vecLoc.x, vecLoc.y);
    // are we touching any food?
    for(int i = food.size()-1; i >= 0; i--) {
      float d = PVector.dist(loc, food.get(i).getPosition());
      // if we are, health goes up
      if(d < r/2) {
        health += 100;
        food.remove(i);
      }
    }
  }

  void update() {
    // death is always near
    health -= 0.2;
  }

  void applyForce(Vec2 v) {
    body.applyForce(v, body.getWorldCenter());
  }

  void seek(Food f) {
    // first we'll need our list of food locations
    ArrayList<Attractor> food = f.getFood();
    Vec2 vecLoc = box2d.getBodyPixelCoord(body);
    PVector loc = new PVector(vecLoc.x, vecLoc.y);
    if(food.size() >= 1) {
      // we'll go to the closest one
      int closestFoodIndex = 0;
      for(int i = food.size()-1; i > 0; i--) {
        // if the distance to our previous closest food is more than the current one we overwrite the index
        if( PVector.dist(loc, food.get(closestFoodIndex).getPosition()) >= PVector.dist(loc, food.get(i).getPosition()) ) {
          closestFoodIndex = i;
        }
      }

      Vec2 force = food.get(closestFoodIndex).attract(this);
      applyForce(force);

      tar = food.get(closestFoodIndex).getPosition();
    } else {
      // hm, no food, lets check if we are already close to our target
      if( PVector.dist(loc, tar) >= 50) {
        // yeah we've likely touched our target, lets pick a random new target
        tar.x = random(width);
        tar.y = random(height);
      }
    }

    // lets apply some force to our target
    // PVector desired = PVector.sub(tar, loc); // we get a vector that points from the location to the target
    // desired.normalize();
    // desired.mult(maxspeed);
    // // steer = desired minus velocity
    // PVector steer = PVector.sub(desired, vel);
    // steer.limit(maxforce);
    // a.setPosition(tar);
    // applyForce(steer);

    // for(int i = 0; i < food.size(); i++) {
    //   Vec2 force = food.get(i).attract(this);
    //   applyForce(force);
    // }

  }

  void borders() {
    // if (loc.x < -r) loc.x = width+r;
    // if (loc.y < -r) loc.y = height+r;
    // if (loc.x > width+r) loc.x = -r;
    // if (loc.y > height+r) loc.y = -r;
  }

  void display() {
    ellipseMode(CENTER);
    stroke(0,0,0, health);
    fill(0,0,0, health);
    Vec2 pos = box2d.getBodyPixelCoord(body);
    ellipse(pos.x, pos.y, r, r);
  }

  PVector getPosition() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    PVector p = new PVector(pos.x, pos.y);
    return p;
  }

  boolean dead() {
    if(health < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
