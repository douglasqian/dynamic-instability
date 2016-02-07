class Tubulin {
   float x, y, s;
   // Generates a random speed for each tubulin floating around
   float xspeed = random(-10,10);
   float yspeed = random(-10,10);
   // Active tubulin is gray
   int r = 126;
   int g = 126;
   int b = 126;
   // Distinguishes between free-roaming tubulin and ones that are bound to a microtubule
   boolean free = true;
   Tubulin(float xpos, float ypos, float size) {
     x = xpos;
     y = ypos;
     s = size;
   }
   void run() {
     display();
     updatePos();
     bounceOffWalls();
   }
   // Draws the tubulin as a circle
   void display() {
     fill(r,g,b);
     ellipse(x, y, s, s);
   }
   // Updates the position by adding to current position
   void updatePos() {
     x = x+xspeed;
     y = y+yspeed;
   }
   // Bounces off the bounding box window
   void bounceOffWalls() {
     float r = s/2;
     if ((x<r) || (x>width-r)) {
       xspeed = -xspeed;
     }
     if ((y<r) || (y>height-r)) {
       yspeed = -yspeed;
     }
     // Bounces off the gamma tubulin molecule in the middle
     float dist = sqrt(sq(x-width/2)+sq(y-height/2));
     if (dist <= 35) {
       xspeed = -xspeed;
       yspeed = -yspeed;
       while (dist <= 35) {
         x = x+xspeed;
         y = y+yspeed;
         dist = sqrt(sq(x-width/2)+sq(y-height/2));
       }
     }
   }
   // Simulates perfectly elastic collision between two tubulins
   // Each tubulin adopts the other's speed values
   void bounceOff(float newxspeed, float newyspeed) {
     xspeed = newxspeed;
     yspeed = newyspeed;
   }
   // Calculates to see if tubulins are overlapping or in contact
   private boolean collidedWithTubulin(Tubulin t2) {
     float dist = sqrt(sq(x-t2.x)+sq(y-t2.y));
     if (dist <= s) {
       return true;
     } else {
       return false;
     }
  }
  // Calculates to see if tubulin comes into contact with the last tubulin on a microtubule
  private boolean collidedWithPlusEnd(Microtubule m) {
    ArrayList<Tubulin> MT = m.microtubule;
    Tubulin ET = MT.get(MT.size()-1);
    float dist = sqrt(sq(x-ET.x) + sq(y-ET.y));
     if (dist <= s && sameAlignment(ET)) {
       return true;
     } else {
       return false;
     }
  }
  // Checks to make sure that the tubulin and the plus end are in a similar alignment
  public boolean sameAlignment(Tubulin t) {
    if (t.x >= width/2 && t.y >= height/2) {
      if (x >= t.x && y >= t.y) {
        return true;
      } else {
        return false;
      }
    }
    if (t.x >= width/2 && t.y < height/2) {
      if (x >= t.x && y < t.y) {
        return true;
      } else {
        return false;
      }
    }
    if (t.x < width/2 && t.y >= height/2) {
      if (x < t.x && y >= t.y) {
        return true;
      } else {
        return false;
      }
    }
    if (t.x < width/2 && t.y < height/2) {
      if (x < t.x && y < t.y) {
        return true;
      } else {
        return false;
      }
    } else {
        return false;
    }
  }
}