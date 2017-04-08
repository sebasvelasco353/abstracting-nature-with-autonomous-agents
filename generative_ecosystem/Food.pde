class Food {
  // ArrayList<PVector> food;
  ArrayList<Attractor> food;
  int r = 3;

  Food(int num) {
    // Start with some food
    food = new ArrayList();
    for(int i = 0; i < num; i++) {
      food.add(new Attractor(r, random(width), random(height)));
    }
  }

  void add(PVector l) {
    // food.add(l.get());
    food.add(new Attractor(r, l.x, l.y));
  }

  void run() {
    for(Attractor f : food) {
      rectMode(CENTER);
      stroke(0);
      fill(175);
      f.display();
    }

    // There's a small chance food will appear randomly
    if(random(1) < 0.001) {
      food.add(new Attractor(r, random(width), random(height)));
    }
  }

  ArrayList getFood() {
    return food;
  }
}
