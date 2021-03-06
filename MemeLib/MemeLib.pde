// caliente: Aaron Li, Joan Chirinos, George Liang
// APCS2 pd8
// Final Project
// 06/08/18

//driver

final int MAIN_SCREEN = 0;
final int ALBUMS_SCREEN = 1;
final int VIEW_SCREEN = 2;
final int NEW_ALBUM_SCREEN = 3;
final int NEW_IMAGE_SCREEN = 4;

int state;
Main m;
Albums a;
View v;
NewAlbum n;
NewImage ni;

void setup() {
  File f = new File(sketchPath() + "/data/album.csv");
  if (!f.exists()) {
    try {
      FileWriter albumWriter = new FileWriter(sketchPath() + "/data/album.csv", true);
      BufferedWriter aW = new BufferedWriter(albumWriter);
      aW.close();
    }
    catch (IOException ioe) {
      println("hmm couldn't write the main album file. there goes our grade");
    }
  }
  size(600, 700);
  background(0, 0, 0);
  state = MAIN_SCREEN;

  m = new Main();
  a = new Albums();
  v = new View();
  n = new NewAlbum();
  ni = new NewImage();
}

void draw() {
  if (state == MAIN_SCREEN) {
    m.setup();
    m.drawOne();
  } else if (state == ALBUMS_SCREEN) {
    a.setup();
    a.drawOne();
  } else if (state == VIEW_SCREEN) {
    v.setup();
    v.drawOne();
  } else if (state == NEW_ALBUM_SCREEN) {
    n.setup();
    n.drawOne();
  } else if (state == NEW_IMAGE_SCREEN) {
    ni.setup();
    ni.drawOne();
  }
  //println(mouseX + ", " + mouseY);
}

void mouseClicked() {
  String ret = "";
  if (state == MAIN_SCREEN) {
    ret = m.onMouseClick();
    if (ret.equals("albums")) {
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
    } else if (ret.equals("newAlbum")) {
      state = NEW_ALBUM_SCREEN;
    } else if (!ret.equals("")) {
      v.setAlbum(ret);
      state = VIEW_SCREEN;
    }
  } else if (state == VIEW_SCREEN) {
    ret = v.onMouseClick();
    println(ret);
    if (ret.equals("back")) {
      state = ALBUMS_SCREEN;
    } else if (!ret.equals("")) {
      ni.setCSV(ret);
      ni.setup();
      state = NEW_IMAGE_SCREEN;
    }
  } else if (state == NEW_ALBUM_SCREEN) {
    ret = n.onMouseClick();
    if (ret.equals("back")) {
      state = ALBUMS_SCREEN;
    } else if (!ret.equals("")) {
      v.setAlbum(ret);
      state = VIEW_SCREEN;
    }
  } else if (state == NEW_IMAGE_SCREEN) {
    ret = ni.onMouseClick();
    if (ret.equals("done")) {
      state = VIEW_SCREEN;
    }
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
