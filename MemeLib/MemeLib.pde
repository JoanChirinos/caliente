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
    m.setup();
    m.drawOne();
  } else if (state == ALBUMS_SCREEN) {
    a.setup();
    a.drawOne();
  } else if (state == VIEW_SCREEN) {
    a.setup();
    v.drawOne();
  }
}

void mouseClicked() {
  String ret = "";
  if (state == MAIN_SCREEN) {
    ret = m.onMouseClick();
    println(ret);
    if (ret.equals("all")) {
      state = VIEW_SCREEN;
    } else if (ret.equals("albums")) {
      //display album pane
      state = ALBUMS_SCREEN;
    } else if (ret.equals("exit")) {
      //exits program
      exit();
    }
  } else if (state == ALBUMS_SCREEN) {
    ret = a.onMouseClick();
    if (ret.equals("back")) {
      state = MAIN_SCREEN;
    }
  } else if (state == VIEW_SCREEN) {
    ret = v.onMouseClick();
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
