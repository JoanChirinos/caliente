class Albums {
  final color backgroundColor = color(226, 237, 255);
  final color buttonColor = color(255, 163, 163);
  final color buttonColorHover = color(255, 209, 209);
  
  final color textColor = color(0, 0, 0);
  final String backButtonText = "Back";
  
  final String albumSelectionTabLabel = "Please select an album";
  
  final color white = color(255, 255, 255);
  final color black = color(0, 0, 0);
  
  int albumPage = 0;
  boolean drawn = false;
  
  ArrayList<String[]> albumList;
  
  String albumSelected;
  
  boolean hasSetUpAlready = false;
  
  boolean canGoForward, canGoBack;

  //Main Screen

  void setup() {
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

  void drawOne() {
    //draw back button
    if (isHovering(25, 25, 100, 50)) drawButton(backButtonText, 30, 25, 25, 100, 50, buttonColorHover);
    else drawButton(backButtonText, 30, 25, 25, 100, 50, buttonColor);
    
    //draw album background
    fill(white);
    rect(50, 100, 500, 575);
    rect(50, 100, 500, 50);
    
    //tab for buttons
    rect(50, 625, 500, 50);
    
    //buttons
    //hover color
    color hc = color(220, 220, 220);
    
    //backPage
    if (isHovering(50, 625, 150, 50)) drawButton("<<", 20, 50, 625, 150, 50, hc);
    else drawButton("<<", 20, 50, 625, 150, 50, white);
    
    //select
    if (isHovering(225, 625, 150, 50)) drawButton("Select", 20, 225, 625, 150, 50, hc);
    else drawButton("Select", 20, 225, 625, 150, 50, white);
    
    //forwardPage
    if (isHovering(400, 625, 150, 50)) drawButton(">>", 20, 400, 625, 150, 50, hc);
    else drawButton(">>", 20, 400, 625, 150, 50, white);
    
    //album selection label
    drawText(albumSelectionTabLabel, 30, 50, 100, 500, 50);
    
    drawAlbums();
    
    //new album
    if (isHovering(380, 25, 195, 50)) drawButton("New album", 30, 380, 25, 195, 50, buttonColorHover);
    else drawButton("New album", 30, 380, 25, 195, 50, buttonColor);
  }
  
  String onMouseClick() {
    if (isHovering(25, 25, 100, 50)) {
      hasSetUpAlready = false;
      drawn = false;
      return "back";
    }
    else if (isHovering(380, 25, 195, 50)) {
      hasSetUpAlready = false;
      drawn = false;
      return "newAlbum";
    }
    return "";
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
  
  void populateAlbumList() {
    //temporary sample
    String[] lines = loadStrings("http://homer.stuy.edu/~jchirinos/albumList.csv");
    for (String s : lines) {
      if (!s.equals("")) albumList.add(s.split(","));
    }
  }
  
  //calls drawAlbum a bunch to draw albums
  void drawAlbums() {
    for (int i = 0; i < albumList.size() && i < 19; i++) {
      drawAlbumTab(albumList.get(i + albumPage * 23), 50, 150 + i * 25, 500, 25);
    }
  }
  
  //info should be [name, dateCreated, numberOfPics]
  void drawAlbumTab(String[] info, float x, float y, float w, float h) {
    float nameWidth = w * 0.6;
    float dateWidth = w * 0.2;
    float numberWidth = w * 0.2;
    drawButton(info[0], 10, x, y, nameWidth, h, white);
    drawButton(info[1], 10, x + nameWidth, y, dateWidth, h, white);
    drawButton(info[2], 10, x + nameWidth + dateWidth, y, numberWidth, h, white);
  }
  
}
