class Albums {
  final color backgroundColor = color(226, 237, 255);
  final color buttonColor = color(255, 163, 163);
  final color buttonColorHover = color(255, 209, 209);
  
  final color textColor = color(0, 0, 0);
  final String backButtonText = "Back";
  
  final String albumSelectionTabLabel = "Please select an album";
  
  final color white = color(255, 255, 255);
  
  String albumSelected;

  //Main Screen

  void setup() {
    background(backgroundColor);
    textAlign(CENTER, CENTER);
    
    albumSelected = "";
  }

  void drawOne() {
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
    color hc = color(220, 220, 220);
    
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
  }
  
  String onMouseClick() {
    if (mouseX >= 25 && mouseX <= 125 && mouseY >= 25 && mouseY <= 75) {
      return "back";
    }
    return "";
  }
  
  void drawButton(String text, int textSize, int x, int y, int w, int h, color c) {
    fill(c);
    rect(x, y, w, h);
    fill(textColor);
    textSize(textSize);
    text(text, x, y, w, h);
  }
  
  boolean isHovering(int x, int y, int w, int h) {
    return (mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h);
  }
  
  void drawText(String text, int size, int x, int y, int w, int h) {
    fill(textColor);
    textSize(size);
    text(text, x, y, w, h);
  }
  
  //calls drawAlbum a bunch to draw albums
  void drawAlbums() {
    //each album
  }
  
  //info should be [name, dateCreated, numberOfPics]
  void drawAlbum(String[] info, int x, int y, int w, int h) {
    
  }
  
}
