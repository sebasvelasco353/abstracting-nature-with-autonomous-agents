class World {
  Box2DProcessing box2d;
  // ArrayList<CreatureBoid> creatureBoids;
  ArrayList<Creature> creatures;
  Food food;

  World(int num, Box2DProcessing _box2d) {
    box2d = _box2d;
    food = new Food(num);
    creatures = new ArrayList<Creature>();
    for(int i = 0; i < num; i++) {
      PVector l = new PVector(random(width), random(height));
      bornRandom(l, box2d);
    }
  }

  void bornRandom(PVector l, Box2DProcessing _box2d) {
    float r = random(1);
    if(r >= .5) {
      CreatureBoid c = new CreatureBoid(l, _box2d);
      creatures.add(c);
    } else {
      CreatureTeamX c = new CreatureTeamX(l, _box2d);
      creatures.add(c);
    }
  }

  void born(float x, float y) {
    PVector l = new PVector(x,y);
    // creatureBoids.add(new CreatureBoid(l, box2d));
    bornRandom(l, box2d);
  }

  void run() {
    food.run();
    for(int i = creatures.size()-1; i >= 0; i--) {
      Creature c = creatures.get(i);
      if(c.health < 175) {
        c.seek(food);
      }
      c.run();
      c.eat(food);

      if(c.dead()) {
        creatures.remove(i);
        food.add(c.getPosition());
      }
    }
  }
}
