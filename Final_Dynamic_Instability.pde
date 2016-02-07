// NOTES FOR OPTIMAL SIMULATION: 
// OPTIMAL CONCENTRATION AROUND 10.0 MICROGRAMS/ML
// BEST IF TUBULIN COLLISION IS REMOVED BECAUSE COLLISIONS LOCALIZE TUBULIN DISTRIBUTION

ArrayList<Tubulin> tubulins = new ArrayList();
ArrayList<Microtubule> microtubules = new ArrayList();

void setup() {
  size(500,500);
  smooth();
  textSize(20);
  mousePressed();
  keyPressed();
  // Sets up the initial gamma tubulin and 6 microtubules
  setUpGammaTubulin();
}

void setUpGammaTubulin() {
  // Sets up 6 Microtubule that are stored in an ArrayList microtubules
  float gnum = int(random(4,14));
  for (int i = 0; i < gnum; i++) {
    Microtubule m = new Microtubule();
    for (Tubulin t : m.microtubule) {
      tubulins.add(t);
    }
    m.dir = i*TWO_PI/gnum;
    m.display();
    microtubules.add(m);
  }
}

void draw() {
  background(50);
  ellipse(250, 250, 60, 60);
  // Updates the position of every tubulin and checks if it collides with a plus end
  for (Tubulin t: tubulins) {
    if (t.free == true) {
      t.run();
      for (Microtubule m : microtubules) {
        // Gains a tubulin if one collides with the plus end
        if (t.collidedWithPlusEnd(m)) {
          m.polymerize(t);
        } else {
          m.time = m.time + 1;
        }
        // After a certain amount of time, microtubule loses a tubulin
        ArrayList<Tubulin> MT = m.microtubule;
        if (m.time > 10000 && MT.size()>1) {
          m.depolymerize();
        }   
      }
    }
  }
  // Draws the microtubules
  for (Microtubule m : microtubules) {
    m.display();
  }
  // Iterates through tubulins twice to simulate each tubulin's interaction with a tubulin nearby
  // COMMENT OUT FOR BEST SIMULATION!!
  int count = 0;
  for (Tubulin t1 : tubulins) {
    // Used to make sure that unique tublin-pairs don't get compared twice
    for (int i = tubulins.size()-1; i >= count; i--) {
      Tubulin t2 = tubulins.get(i);
      if (t1 != t2 && t1.free == true && t2.free == true && t1.collidedWithTubulin(t2)) {
          float y1 = t1.yspeed;
          float x1 = t1.xspeed;
          float y2 = t2.yspeed;
          float x2 = t2.xspeed;
          t1.bounceOff(x2, y2);
          t1.updatePos();
          t2.bounceOff(x1, y1);
          t2.updatePos();
      }
    }
    count++;
  }
  // COMMENT OUT FOR BEST SIMULATION!!
  // Prints concentration of tubulin dimers
  fill(20,200,200);
  text("[Tubulin] =", 20, 480);
  text(float(tubulins.size())/400.0, 130, 480);
  text("\u03BCg/mL", 200, 480);
}

// mousePressed adds a tubulin dimer onto the ArrayList tubulins
void mousePressed() {
  tubulins.add(new Tubulin(mouseX, mouseY, 10));
}

// keyPressed helps change the concentration of tubulin dimers
void keyPressed() {
  // H (Half) halves the active tubulin concentration
  if (key == 'h'|| key == 'H') {
    for (int i = 0; i < tubulins.size(); i++) {
      tubulins.remove(0);
    }
  // K (Kill) removes all active tubulin
  } else if (key == 'k' || key == 'K') {
    int size = tubulins.size();
    for (int i = 0; i < size; i++) {
        tubulins.remove(0);
    }
  } 
  // F (Fill) adds 50 new tubulin dimers
  float dist = sqrt(sq(mouseX-width/2)+sq(mouseY-height/2));
  if (dist > 35) { 
      if (key == 'f' || key == 'F') {
      for (int i = 0; i < 50; i++) {
        tubulins.add(new Tubulin(mouseX, mouseY, 10));
      }
    }
  }
}