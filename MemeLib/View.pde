class View {
  
  final color backgroundColor = color(226, 237, 255);
  final color buttonColor = color(255, 163, 163);
  final color buttonColorHover = color(255, 209, 209);
  final color textColor = color(0, 0, 0);
  
  boolean imageWasDrawn = false;
  
  String fileName;
  
  ArrayList<String> urlList;

  //Main Screen

  void setup() {
    background(backgroundColor);
    textAlign(CENTER, CENTER);
  }
  
  void setAlbum(String fName) {
    fileName = fName;
    loadURLs();
  }

  void drawOne() {
    textAlign(LEFT, CENTER);
    drawText("Album: " + fileName, 20, 115, 25, 475, 35);
    textAlign(CENTER, CENTER);
    
    //back button
    if (isHovering(25, 25, 75, 35)) drawButton("Back", 20, 25, 25, 75, 35, buttonColorHover);
    else drawButton("Back", 20, 25, 25, 75, 35, buttonColor);
    
    //image area
    drawButton("", 1, 20, 75, 560, 560, color(255, 255, 255));
    
    if (!imageWasDrawn) {
      drawImage();
      imageWasDrawn = true;
    }
    
  }
  
  String onMouseClick() {
    //back button
    if (isHovering(25, 25, 75, 35)) {
      return "back";
    }
    return "";
  }
  
  void drawImage() {
    
  }
  
  void loadURLs() {
    urlList = new ArrayList<String>();
    String[] urls = loadStrings(fileName + ".csv");
    for (String url : urls) {
      urlList.add(url);
    }
  }
  
  void displayImage(int index) {
    
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
