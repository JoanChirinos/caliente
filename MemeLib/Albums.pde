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
    if (isHovering(50, 625, 250, 50)) drawButton("Previous page", 20, 50, 625, 250, 50, hc);
    else drawButton("Previous page", 20, 50, 625, 250, 50, white);

    //forwardPage
    if (isHovering(300, 625, 250, 50)) drawButton("Next page", 20, 300, 625, 250, 50, hc);
    else drawButton("Next page", 20, 300, 625, 250, 50, white);

    //album selection label
    drawText(albumSelectionTabLabel, 30, 50, 100, 500, 50);

    drawAlbums();

    //new album
    if (isHovering(380, 25, 195, 50)) drawButton("New album", 30, 380, 25, 195, 50, buttonColorHover);
    else drawButton("New album", 30, 380, 25, 195, 50, buttonColor);
    
    //sort-by-name button
    if (isHovering(140, 25, 105, 50)) drawButton("Sort by name", 15, 140, 25, 105, 50, buttonColorHover);
    else drawButton("Sort by name", 15, 140, 25, 105, 50, buttonColor);
    
    //sort-by-date button
    if (isHovering(260, 25, 105, 50)) drawButton("Sort by date", 15, 260, 25, 105, 50, buttonColorHover);
    else drawButton("Sort by date", 15, 260, 25, 105, 50, buttonColor);
  }

  String onMouseClick() {
    if (isHovering(25, 25, 100, 50)) {
      hasSetUpAlready = false;
      return "back";
    } else if (isHovering(380, 25, 195, 50)) {
      hasSetUpAlready = false;
      return "newAlbum";
    } else if (isHovering(50, 625, 250, 50) && albumPage > 0) {
      albumPage--;
      drawAlbums();
    } else if (isHovering(300, 625, 250, 50) && (albumPage + 1) * 19 < albumList.size()) {
      println("page " + albumPage + ", aLsize: " + albumList.size());
      albumPage++;
      drawAlbums();
    } else if (isHovering(140, 25, 105, 50)) {
      sortAlbumList();
      drawAlbums();
    } else if (isHovering(260, 25, 105, 50)) {
      hasSetUpAlready = false;
    }

    //now let's detect every button click and return the right thing Dx
    for (int i = 0; i < albumList.size() && i < 19; i++) {
      if (i + albumPage * 19 < albumList.size() && isHovering(50, 150 + i * 25, 500, 25)) {
        println("hovering over " + i);
        hasSetUpAlready = false;
        return (albumList.get(i + albumPage * 19)[0]);
      }
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
    String[] lines = loadStrings("album.csv");
    for (String s : lines) {
      if (!s.equals("")) albumList.add(s.split(","));
    }
  }

  //calls drawAlbum a bunch to draw albums
  void drawAlbums() {
    for (int i = 0; i < albumList.size() && i < 19; i++) {
      if (i + albumPage * 19 < albumList.size()) {
        drawAlbumTab(albumList.get(i + albumPage * 19), 50, 150 + i * 25, 500, 25);
      }
    }
  }

  //info should be [name, dateCreated, numberOfPics]
  void drawAlbumTab(String[] info, float x, float y, float w, float h) {
    float nameWidth = w * 0.6;
    float dateWidth = w * 0.4;
    drawButton(info[0], 10, x, y, nameWidth, h, white);
    drawButton(info[1], 10, x + nameWidth, y, dateWidth, h, white);
  }




  //sorts
  
  void quickSortHelper(int left, int right) {
    if (left < right) {
      int pvt = partition(left, right);
      quickSortHelper(left, pvt - 1);
      quickSortHelper(pvt + 1, right);
    }
  }

  int partition(int left, int right) {
    int pvtPos = left + (int)(Math.random() * (right - left - 1));

    String pvtVal = albumList.get(pvtPos)[0];
    swap(pvtPos, right);
    int storePos = left;
    for (int i = left; i < right; i++) {
      if (albumList.get(i)[0].compareTo(pvtVal) < 0) {
        swap(storePos, i);
        storePos++;
      }
    }
    swap(storePos, right);
    return storePos;
  }

  void sortAlbumList() {
    quickSortHelper(0, albumList.size() - 1);
  }
  
  void swap(int index1, int index2) {
    albumList.set(index1, albumList.set(index2, albumList.get(index1)));
  }
}
