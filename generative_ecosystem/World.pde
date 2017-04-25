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
      bornRandomCreature(l, box2d);
    }
  }

  void bornRandomCreature(PVector l, Box2DProcessing _box2d) {
    int numCreatureClasses = 2; // don't forget to update!

    float r = random(1.0);
    float threshold = 1.0 / numCreatureClasses;

    // not the prettiest way, but unfortunately we can't dynamically call random classes from the same abstract class
    if(r < threshold * 1) {
      CreatureBoid c = new CreatureBoid(l, _box2d);
      creatures.add(c);
    } else if(r < threshold * 2) {
      CreatureTeamX c = new CreatureTeamX(l, _box2d);
      creatures.add(c);
    }
    // we'll add if statements for the other creatures too
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