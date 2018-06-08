class View {
  
  final color backgroundColor = color(226, 237, 255);
  final color buttonColor = color(255, 163, 163);
  final color buttonColorHover = color(255, 209, 209);
  final color textColor = color(0, 0, 0);
  
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
    drawText("Album: " + fileName, 20, 25, 25, 550, 40);
  }
  
  String onMouseClick() {
    return "";
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
