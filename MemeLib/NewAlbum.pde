// caliente: Aaron Li, Joan Chirinos, George Liang
// APCS2 pd8
// Final Project
// 06/08/18

class NewAlbum {
  
  final color backgroundColor = color(226, 237, 255);
  final color buttonColor = color(255, 163, 163);
  final color buttonColorHover = color(255, 209, 209);
  final color textColor = color(0, 0, 0);
  final color white = color(255, 255, 255);
  
  boolean hasSetUpAlready = false;
  
  int keyPressDelay;
  
  String currentName;
  
  Backend b;
  
  void setup() {
    if (!hasSetUpAlready) {
      background(backgroundColor);
      textAlign(CENTER, CENTER);
      
      currentName = "";
      
      hasSetUpAlready = true;
      keyPressDelay = 7;
      b = new Backend();
    }
  }
  
  void drawOne() {
    drawText("New album name", 30, 50, 50, 500, 50);
    textAlign(LEFT, CENTER);
    drawButton(currentName, 35, 50, 110, 500, 50, white);
    textAlign(CENTER, CENTER);
    
    if (isHovering(450, 170, 100, 50)) drawButton("Okay", 30, 450, 170, 100, 50, color(220, 220, 220));
    else drawButton("Okay", 30, 450, 170, 100, 50, white);
    
    if (isHovering(50, 170, 100, 50)) drawButton("Back", 30, 50, 170, 100, 50, color(220, 220, 220));
    else drawButton("Back", 30, 50, 170, 100, 50, white);
    
    drawText("Only letters and numbers please", 15, 50, 210, 500, 50);
    
    if (keyPressed) {
      keyPressDelay--;
    }
    
    if (keyPressDelay == 0 && keyPressed) {
      keyPressDelay = 7;
      char k = key;
      
      if (k == BACKSPACE) {
        if (currentName.length() > 0) currentName = currentName.substring(0, currentName.length() - 1);
      }
      else if (currentName.length() <= 15 && (Character.isLetter(k) || Character.isDigit(k))) {
        currentName += key;
      }
    }
    else if (keyPressDelay > 1) {
      keyPressDelay--;
      println(keyPressDelay);
    }
  }
  
  String onMouseClick() {
    if (isHovering(450, 170, 100, 50) && !currentName.equals("album") && !currentName.equals("")) {
      b.makeAlbum(currentName);
      println("clicked");
      hasSetUpAlready = false;
      return currentName;
    }
    else if (isHovering(50, 170, 100, 50)) {
      hasSetUpAlready = false;
      return "back";
    }
    else  return "";
  }
  
  void drawButton(String text, float textSize, float x, float y, float w, float h, color c) {
    fill(c);
    rect(x, y, w, h);
    fill(textColor);
    textSize(textSize);
    text(text, x, y, w, h);
  }
  
  boolean isHovering(float x, float y, float w, float h) {
    return (mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h);
  }
  
  void drawText(String text, float size, float x, float y, float w, float h) {
    fill(textColor);
    textSize(size);
    text(text, x, y, w, h);
  }
  
}
