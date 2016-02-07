class Microtubule {
    ArrayList<Tubulin> microtubule;
    // Sets up orientation of the microtubule
    float dir;
    // Tells the microtubule when to pop off a tubulin
    int time;
    Microtubule() {
      microtubule = new ArrayList();
      // Adds 10 tubulin to every microtubule
      for (int i = 0; i < 10; i++) {
        Tubulin t = new Tubulin(0, 0, 10);
        // Tubulin on microtubules are green, not gray
        // Indicates that they are not free to move
        t.r = 120;
        t.g = 180;
        t.b = 50;
        t.free = false;
        microtubule.add(t);
      }
      time = 19950;
    }
    // Draws the microtubules in the dir orientation
    void display() {
      for (int i = 0; i < microtubule.size(); i++) {
        Tubulin t = microtubule.get(i);
        t.x = 10*cos(dir)*i + 30*cos(dir)+250;
        t.y = 10*sin(dir)*i + 30*sin(dir)+250;
        t.display();
      }
    }   
    // Adds a tubulin onto the microtubule
    void polymerize(Tubulin t) {
      microtubule.add(t);
      t.xspeed = 0;
      t.yspeed = 0;
      t.r = 120;
      t.g = 180;
      t.b = 50;
      t.free = false;
      time = 0;
    }
    // Takes all the tubulin off of the microtubule in a depolymerization event
    void depolymerize() {
      for (int i = microtubule.size()-1; i > 0; i--) {
        Tubulin t = microtubule.get(i);
        t.xspeed = random(-5,5);
        t.yspeed = random(-5,5);
        t.r = 126;
        t.g = 126;
        t.b = 126;
        t.free = true;
        microtubule.remove(i);
      }
      time = 9999;
    }
}