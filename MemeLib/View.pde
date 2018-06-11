// caliente: Aaron Li, Joan Chirinos, George Liang
// APCS2 pd8
// Final Project
// 06/08/18

class View {

  final color backgroundColor = color(226, 237, 255);
  final color buttonColor = color(255, 163, 163);
  final color buttonColorHover = color(255, 209, 209);
  final color textColor = color(0, 0, 0);
  final color white = color(255, 255, 255);

  boolean imageWasDrawn = false;
  boolean imageBackgroundWasDrawn = false;
  boolean hasSetUp = false;

  boolean shuffle, repeat, play, indexSet = false;

  String fileName;

  int indexAt = -1;
  ArrayList<String> urlList;
  ArrayList<String> urlListForShuffle;

  int tickCounter = 300;

  Backend b = new Backend();

  //Main Screen

  void setup() {
    if (!hasSetUp) {
      copy();
      imageMode(CENTER);
      background(backgroundColor);
      textAlign(CENTER, CENTER);
      hasSetUp = true;
      tickCounter = 300;
      loadURLs();
    }
  }

  void setAlbum(String fName) {
    fileName = fName;
    loadURLs();
  }

  void drawOne() {
    //println(play);
    if (play) {
      tickCounter--;
    } else {
      tickCounter = 300;
    }
    //println(urlList);
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
    if (!imageBackgroundWasDrawn) {
      drawButton("", 1, 20, 75, 560, 560, white);
      imageBackgroundWasDrawn = true;
    }

    //shuffle, back, play, forward, repeat
    //100 wide, 15 gutter, +1 on each side
    color hoverColor = color(220, 220, 220);

    if (shuffle) drawButton("Shuffle", 20, 18, 645, 100, 50, color(145, 255, 135));
    else drawButton("Shuffle", 20, 18, 645, 100, 50, color(255, 81, 81));

    if (isHovering(134, 645, 100, 50)) drawButton("<<", 20, 134, 645, 100, 50, hoverColor);
    else drawButton("<<", 20, 134, 645, 100, 50, white);

    if (play) {
      if (isHovering(250, 645, 100, 50)) drawButton("Stop", 20, 250, 645, 100, 50, hoverColor);
      else drawButton("Stop", 20, 250, 645, 100, 50, white);
    } else {
      if (isHovering(250, 645, 100, 50)) drawButton("Play", 20, 250, 645, 100, 50, hoverColor);
      else drawButton("Play", 20, 250, 645, 100, 50, white);
    }

    if (isHovering(365, 645, 100, 50)) drawButton(">>", 20, 365, 645, 100, 50, hoverColor);
    else drawButton(">>", 20, 365, 645, 100, 50, white);

    if (repeat) drawButton("Repeat", 20, 482, 645, 100, 50, color(145, 255, 135));
    else drawButton("Repeat", 20, 482, 645, 100, 50, color(255, 81, 81));

    if (tickCounter == 0) {
      imageWasDrawn = false;
    }
    
    if (!play) {
      copy();
    }

    if (!imageWasDrawn && play) {
      drawImage();
      imageWasDrawn = true;
      tickCounter = 300;
    }

    //println(tickCounter);
  }

  String onMouseClick() {
    //back button
    if (isHovering(25, 25, 75, 35)) {
      imageWasDrawn = false;
      imageBackgroundWasDrawn = false;
      hasSetUp = false;
      tickCounter = 300;
      shuffle = repeat = play = false;
      indexAt = -1;
      return "back";
    } else if (isHovering(475, 25, 100, 35)) {
      imageWasDrawn = false;
      imageBackgroundWasDrawn = false;
      hasSetUp = false;
      tickCounter = 300;
      return fileName + ".csv";
    } else if (isHovering(18, 645, 100, 50)) {
      shuffle = !shuffle;
    } else if (isHovering(482, 645, 100, 50)) {
      repeat = !repeat;
    } else if (isHovering(250, 645, 100, 50)) {
      play = !play;
      indexAt = 0;
      indexSet = true;
    }
    
    else if (isHovering(134, 645, 100, 50)) {
      indexAt--;
      if (indexAt < 0) {
        indexAt = urlList.size() - 1;
      }
      println(indexAt);
      indexSet = true;
      drawImage();
    }
    
    else if (isHovering(365, 645, 100, 50)) {
      indexAt++;
      if (indexAt == urlList.size()) {
        indexAt = 0;
      }
      println(indexAt);
      indexSet = true;
      drawImage();
    }
    return "";
  }

  boolean setIndex() {
    if (shuffle && repeat) {
      indexAt = (int)(random(urlList.size()));
    }
    
    else if (shuffle) {
      println(urlListForShuffle);
      if (urlListForShuffle.size() == 0) {
        copy();
        println(urlListForShuffle);
        println("finished the shuffle");
        play = false;
        return false;
      }
      indexAt = (int)(random(urlListForShuffle.size()));
      urlListForShuffle.remove(indexAt);
    }
    
    else if (repeat) {
      indexAt = (indexAt + 1) % urlList.size();
    }
    
    else {
      if (indexAt == urlList.size() - 1) {
        play = false;
        indexAt = -1;
        return false;
      }
      else {
        indexAt++;
      }
    }
    
    return true;
  }

  void drawImage() {
    drawButton("", 1, 20, 75, 560, 560, white);
    println(indexSet);
    //kinda dont wanna mess with an empty urlList
    if (urlList.size() == 0) {
      return;
    }
    try {
      if (!indexSet) {
        if (!setIndex()) {
          return;
        }
      } else indexSet = false;
      PImage image;
      try {
        image = loadImage(urlList.get(indexAt).split(",")[0]);
      }
      catch (IndexOutOfBoundsException iob) {
        indexAt = -1;
        image = loadImage(urlList.get(indexAt).split(",")[0]);
        println("had to reset indexAt");
      }
      if (image.width > 560 || image.height > 560) {
        float scale = min(560.0 / image.width, 560.0 / image.height);
        image.resize(int(image.width * scale) - 1, int(image.height * scale) - 1);
      }
      image(image, 300, 355);
    }
    catch (NullPointerException npe) {
      println("couldn't load that image. skipping");
      indexAt = (indexAt + 1) % urlList.size();
    }
  }

  void loadURLs() {
    urlList = new ArrayList<String>();
    println("loading from: " + sketchPath() + "/data/" + fileName + ".csv");
    String[] urls = loadStrings(sketchPath() + "/data/" + fileName + ".csv");
    for (String x : urls) {
      for (String url : x.split(",")) {
        if (!url.equals("")) urlList.add(url);
      }
    }
    println(urlList);
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

  //copies from urlList to urlListForRandom
  void copy() {
    urlListForShuffle = new ArrayList<String>();
    for (String s : urlList) {
      urlListForShuffle.add(s);
    }
  }
}
