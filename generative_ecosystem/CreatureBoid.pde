class CreatureBoid extends Creature {
  ArrayList<PVector> history = new ArrayList<PVector>();
  int tailLen = 20;
  color cHead = color(246, 236, 19);
  color cHeadDead = color(0, 0, 250);
  color cTail = color(240, 102, 153);

  CreatureBoid(PVector l, Box2DProcessing _box2d) {
    super(l, _box2d);
  }

  // Method to update history
  void history() {
    history.add(getPosition());
    while (history.size () > tailLen && tailLen > 0) {
      history.remove(0);
    }
  }

  // we overwrite the Creature display fucntion and make our own
  void display() {
    history();

    noStroke();
    boolean bEven = false;
    int counter = 0;

    // we make a boid trail based on the location history
    for (PVector v : history) {
      if (!bEven && counter < (tailLen-2)) {
        bEven = true;
        PVector pos = v;
        pushMatrix();
        translate(pos.x, pos.y);
        color healthLerp = color(lerpColor(cHead, cHeadDead, map(health, 200, 0, 0, 1)));
        color lerp1 = color(lerpColor(cTail, healthLerp, map(counter, 0, history.size(), 0, 1)));
        fill(lerp1);
        ellipse(0, 0, 6, 6);

        PVector v2 = PVector.sub(pos, new PVector(width/2, height/2));
        float deg = degrees(v2.heading2D())+90;

        if (deg > 170 && deg < 190) {
          float dist = deg - 175;
          if (dist < 0) {
            dist = dist*-1;
          }
          float dotSize = map(dist, 10, 0, 6, 10);
          ellipse(0, 0, dotSize, dotSize);
        }
        popMatrix();
      } else {
        bEven = false;
      }
      counter++;
    }
    // displayDebug();
  }
}
