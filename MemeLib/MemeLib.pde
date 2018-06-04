//driver

final int MAIN_SCREEN = 0;
final int ALBUMS_SCREEN = 1;
final int VIEW_SCREEN = 2;

int state;
Main m;
Albums a;
View v;

void setup() {
  size(600, 800);
  background(0, 0, 0);
  state = MAIN_SCREEN;

  m = new Main();
  a = new Albums();
  v = new View();
}

void draw() {
  if (state == MAIN_SCREEN) {
    m.drawOne();
  }
  else if (state == ALBUMS_SCREEN) {
    a.drawOne();
  }
  else if (state == VIEW_SCREEN) {
    v.drawOne();
  }
}

void mouseClicked() {
  if (state == MAIN_SCREEN) {
    m.onMouseClick();
  }
  else if (state == ALBUMS_SCREEN) {
    a.onMouseClick();
  }
  else if (state == VIEW_SCREEN) {
    v.onMouseClick();
  }
}

/*
STATES
if (state == MAIN_SCREEN) {
  
}
else if (state == ALBUMS_SCREEN) {
  
}
else if (state == VIEW_SCREEN) {
  
}
*/
