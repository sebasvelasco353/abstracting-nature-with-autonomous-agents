class World {

  Box2DProcessing box2d;
  ArrayList<Creature> creatures;
  Food food;

  World(int num, Box2DProcessing _box2d) {
    box2d = _box2d;
    food = new Food(num);
    creatures = new ArrayList<Creature>();
    for(int i = 0; i < num; i++) {
      PVector l = new PVector(random(width), random(height));
      creatures.add(new Creature(l, box2d));
    }
  }

  void born(float x, float y) {
    PVector l = new PVector(x,y);
    creatures.add(new Creature(l, box2d));
  }

  void run() {
    food.run();

    for(int i = creatures.size()-1; i >= 0; i--) {
      Creature c = creatures.get(i);
      if(c.health < 150) {
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
