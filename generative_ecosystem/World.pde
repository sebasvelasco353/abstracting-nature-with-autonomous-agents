class World {

  Box2DProcessing box2d;
  ArrayList<CreatureBoid> creatureBoids;
  Food food;

  World(int num, Box2DProcessing _box2d) {
    box2d = _box2d;
    food = new Food(num);
    creatureBoids = new ArrayList<CreatureBoid>();
    for(int i = 0; i < num; i++) {
      PVector l = new PVector(random(width), random(height));
      creatureBoids.add(new CreatureBoid(l, box2d));
    }
  }

  void born(float x, float y) {
    PVector l = new PVector(x,y);
    creatureBoids.add(new CreatureBoid(l, box2d));
  }

  void run() {
    food.run();

    for(int i = creatureBoids.size()-1; i >= 0; i--) {
      CreatureBoid c = creatureBoids.get(i);
      if(c.health < 175) {
        c.seek(food);
      }
      c.run();
      c.eat(food);

      if(c.dead()) {
        creatureBoids.remove(i);
        food.add(c.getPosition());
      }
    }
  }
}
