import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class MemeLib extends PApplet {

//driver

final int MAIN_SCREEN = 0;
final int ALBUMS_SCREEN = 1;
final int VIEW_SCREEN = 2;

int state;
Main m;
Albums a;
View v;

public void setup() {
  
  background(0, 0, 0);
  state = MAIN_SCREEN;

  m = new Main();
  a = new Albums();
  v = new View();
}

public void draw() {
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

public void mouseClicked() {
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
class Albums {
  final int backgroundColor = color(226, 237, 255);
  final int buttonColor = color(255, 163, 163);
  final int buttonColorHover = color(255, 209, 209);
  
  final int textColor = color(0, 0, 0);
  final String backButtonText = "Back";
  
  final String albumSelectionTabLabel = "Please select an album";
  
  final int white = color(255, 255, 255);
  final int black = color(0, 0, 0);
  
  int albumPage = 0;
  boolean drawn = false;
  
  ArrayList<String[]> albumList;
  
  String albumSelected;
  
  boolean hasSetUpAlready = false;
  
  boolean canGoForward, canGoBack;

  //Main Screen

  public void setup() {
    if (!hasSetUpAlready) {
      background(backgroundColor);
      textAlign(CENTER, CENTER);
      
      albumSelected = "";
      
      albumList = new ArrayList<String[]>();
      
      populateAlbumList();
      
      for (String[] i : albumList) {
        for (String s : i) {
          print(s);
          print("\t");
        }
        println();
      }
      hasSetUpAlready = true;
    }
  }

  public void drawOne() {
    //draw back button
    if (isHovering(25, 25, 100, 50)) drawButton(backButtonText, 30, 25, 25, 100, 50, buttonColorHover);
    else drawButton(backButtonText, 30, 25, 25, 100, 50, buttonColor);
    
    //draw album background
    fill(white);
    rect(50, 100, 500, 675);
    rect(50, 100, 500, 50);
    
    //tab for buttons
    rect(50, 725, 500, 50);
    
    //buttons
    //hover color
    int hc = color(220, 220, 220);
    
    //backPage
    if (isHovering(50, 725, 150, 50)) drawButton("<<", 20, 50, 725, 150, 50, hc);
    else drawButton("<<", 20, 50, 725, 150, 50, white);
    
    //select
    if (isHovering(225, 725, 150, 50)) drawButton("Select", 20, 225, 725, 150, 50, hc);
    else drawButton("Select", 20, 225, 725, 150, 50, white);
    
    //forwardPage
    if (isHovering(400, 725, 150, 50)) drawButton(">>", 20, 400, 725, 150, 50, hc);
    else drawButton(">>", 20, 400, 725, 150, 50, white);
    
    //album selection label
    drawText(albumSelectionTabLabel, 30, 50, 100, 500, 50);
    
    drawAlbums();
  }
  
  public String onMouseClick() {
    if (mouseX >= 25 && mouseX <= 125 && mouseY >= 25 && mouseY <= 75) {
      hasSetUpAlready = false;
      drawn = false;
      return "back";
    }
    return "";
  }
  
  public void drawButton(String text, float textSize, float x, float y, float w, float h, int c) {
    fill(c);
    rect(x, y, w, h);
    fill(textColor);
    textSize(textSize);
    text(text, x, y, w, h);
  }
  
  public boolean isHovering(float x, float y, float w, float h) {
    return (mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h);
  }
  
  public void drawText(String text, float size, float x, float y, float w, float h) {
    fill(textColor);
    textSize(size);
    text(text, x, y, w, h);
  }
  
  public void populateAlbumList() {
    //temporary sample
    String[] lines = loadStrings("http://homer.stuy.edu/~jchirinos/sampleAlbumList.csv");
    for (String s : lines) {
      if (!s.equals("")) albumList.add(s.split(","));
    }
  }
  
  //calls drawAlbum a bunch to draw albums
  public void drawAlbums() {
    for (int i = 0; i < 23; i++) {
      if (i + albumPage * 23 < albumList.size()) {
        drawAlbumTab(albumList.get(i + albumPage * 23), 50, 150 + i * 25, 500, 25);
      }
    }
  }
  
  //info should be [name, dateCreated, numberOfPics]
  public void drawAlbumTab(String[] info, float x, float y, float w, float h) {
    float nameWidth = w * 0.6f;
    float dateWidth = w * 0.2f;
    float numberWidth = w * 0.2f;
    drawButton(info[0], 10, x, y, nameWidth, h, white);
    drawButton(info[1], 10, x + nameWidth, y, dateWidth, h, white);
    drawButton(info[2], 10, x + nameWidth + dateWidth, y, numberWidth, h, white);
  }
  
}
//Creates a new Deque to store files in one album
public void makeAlbum(){}

//Adds an image by url
public PImage add(String url){
  PImage meme;
  meme = loadImage(url);
  return meme;
}

//Deletes an image from an album
public void delete(){}

//Skips to next image in album
public void skip(){}

//Skips to previous image in album
public void prev(){}

//Displays image in the image screen
public void displayImage(){}

//Plays the slideshow in the album by following Deque order
class Main {

  final int backgroundColor = color(226, 237, 255);
  final int buttonColor = color(255, 163, 163);
  final int buttonColorHover = color(255, 209, 209);
  
  final int textColor = color(0, 0, 0);
  final String buttonOne = "Show all pictures";
  final String buttonTwo = "Show all albums";
  final String buttonThree = "Exit";

  //Main Screen

  public void setup() {
    background(backgroundColor);
    textAlign(CENTER, CENTER);
  }

  public void drawOne() {
    if (isHovering(50, 75, 500, 200)) drawButton(buttonOne, 40, 50, 75, 500, 200, buttonColorHover);
    else drawButton(buttonOne, 40, 50, 75, 500, 200, buttonColor);

    if (isHovering(50, 300, 500, 200)) drawButton(buttonTwo, 40, 50, 300, 500, 200, buttonColorHover);
    else drawButton(buttonTwo, 40, 50, 300, 500, 200, buttonColor);
    
    if (isHovering(50, 525, 500, 200)) drawButton(buttonThree, 40, 50, 525, 500, 200, buttonColorHover);
    else drawButton(buttonThree, 40, 50, 525, 500, 200, buttonColor);
  }

  public String onMouseClick() {
    if (isHovering(50, 75, 500, 200)) {
      return "all";
    } else if (isHovering(50, 300, 500, 200)) {
      return "albums";
    } else if (isHovering(50, 525, 500, 200)) {
      return "exit";
    }
    return "";
  }
  
  public void drawButton(String text, float textSize, float x, float y, float w, float h, int c) {
    fill(c);
    rect(x, y, w, h);
    fill(textColor);
    textSize(textSize);
    text(text, x, y, w, h);
  }
  
  public boolean isHovering(float x, float y, float w, float h) {
    return (mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h);
  }
  
  public void drawText(String text, float size, float x, float y, float w, float h) {
    fill(textColor);
    textSize(size);
    text(text, x, y, w, h);
  }
}
class View {
  
  final int backgroundColor = color(226, 237, 255);
  final int buttonColor = color(255, 163, 163);
  final int buttonColorHover = color(255, 209, 209);

  //Main Screen

  public void setup() {
    background(backgroundColor);
  }

  public void drawOne() {
    
  }
  
  public String onMouseClick() {
    return "";
  }
}
  public void settings() {  size(600, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "MemeLib" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
