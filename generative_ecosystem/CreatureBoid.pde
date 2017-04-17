class CreatureBoid extends Creature {
  ArrayList<PVector> history = new ArrayList<PVector>();
  int tailLen = 20;
  color cHead = color(246, 236, 19);
  color cTail = color(240, 102, 153);

  CreatureBoid(PVector l, Box2DProcessing _box2d) {
    super(l, _box2d);
  }
}
