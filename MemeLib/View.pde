class View {
  
  final color backgroundColor = color(226, 237, 255);
  final color buttonColor = color(255, 163, 163);
  final color buttonColorHover = color(255, 209, 209);
  final color textColor = color(0, 0, 0);
  final color white = color(255, 255, 255);
  
  boolean imageWasDrawn = false;
  
  boolean shuffle, repeat;
  
  String fileName;
  
  int indexAt = 0;
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
    drawText("Album: " + fileName, 20, 115, 25, 350, 35);
    textAlign(CENTER, CENTER);
    
    //back button
    if (isHovering(25, 25, 75, 35)) drawButton("Back", 20, 25, 25, 75, 35, buttonColorHover);
    else drawButton("Back", 20, 25, 25, 75, 35, buttonColor);
    
    //add image button
    if (isHovering(475, 25, 100, 35)) drawButton("Add image", 20, 475, 25, 100, 35, buttonColorHover);
    else drawButton("Add image", 20, 475, 25, 100, 35, buttonColor);
    
    //image area
    drawButton("", 1, 20, 75, 560, 560, white);
    
    //shuffle, back, play, forward, repeat
    //100 wide, 15 gutter, +1 on each side
    drawButton("Shuffle", 20, 16, 570, 100, 50, white);
    
    drawButton("<<", 20, 131, 570, 100, 50, white);
    
    drawButton("Play", 20, 246, 570, 100, 50, white);
    
    drawButton(">>", 20, 361, 570, 100, 50, white);
    
    drawButton("Repeat", 20, 476, 570, 100, 50, white);
    
    if (!imageWasDrawn) {
      drawImage();
      imageWasDrawn = true;
    }
    
  }
  
  String onMouseClick() {
    //back button
    if (isHovering(25, 25, 75, 35)) {
      imageWasDrawn = false;
      return "back";
    }
    else if (isHovering(575, 25, 100, 35)) {
      imageWasDrawn = false;
      return fileName + ".csv";
    }
    return "";
  }
  
  void drawImage() {
    //kinda dont wanna mess with an empty urlList
    if (urlList.size() == 0) {
      return;
    }
    try {
      PImage image = loadImage(urlList.get(indexAt));
      
      if (image.width > 560 || image.height > 560) {
        float scale = min(860.0 / image.width, 860.0 / image.height);
        image.resize(int(image.width * scale), int(image.height * scale));
      }
      
    }
    catch (NullPointerException npe) {
      println("couldn't load that image. skipping");
      indexAt = (indexAt + 1) % urlList.size();
    }
    /*catch (Exception e) {
      println("something else went seriously wrong in view");
    }*/
  }
  
  void loadURLs() {
    urlList = new ArrayList<String>();
    String[] urls = loadStrings(fileName + ".csv");
    for (String url : urls) {
      urlList.add(url);
    }
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
