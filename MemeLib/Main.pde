class Main {

  final color backgroundColor = color(226, 237, 255);
  final color buttonColor = color(255, 163, 163);
  final color buttonColorHover = color(255, 209, 209);
  
  final color textColor = color(0, 0, 0);
  final String buttonOne = "Show all pictures";
  final String buttonTwo = "Show all albums";
  final String buttonThree = "Exit";

  //Main Screen

  void setup() {
    background(backgroundColor);
    textAlign(CENTER, CENTER);
  }

  void drawOne() {
    if (isHovering(50, 25, 500, 200)) drawButton(buttonOne, 40, 50, 25, 500, 200, buttonColorHover);
    else drawButton(buttonOne, 40, 50, 25, 500, 200, buttonColor);

    if (isHovering(50, 250, 500, 200)) drawButton(buttonTwo, 40, 50, 250, 500, 200, buttonColorHover);
    else drawButton(buttonTwo, 40, 50, 250, 500, 200, buttonColor);
    
    if (isHovering(50, 475, 500, 200)) drawButton(buttonThree, 40, 50, 475, 500, 200, buttonColorHover);
    else drawButton(buttonThree, 40, 50, 475, 500, 200, buttonColor);
  }

  String onMouseClick() {
    if (isHovering(50, 75, 500, 200)) {
      return "all";
    } else if (isHovering(50, 250, 500, 200)) {
      return "albums";
    } else if (isHovering(50, 475, 500, 200)) {
      return "exit";
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
}
