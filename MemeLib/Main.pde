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
    drawText("MemeLib", 130, 10, 25, 580, 200);
    drawText("Your cool new image library application", 25, 50, 190, 500, 100);

    if (isHovering(50, 350, 500, 150)) drawButton(buttonTwo, 30, 50, 350, 500, 150, buttonColorHover);
    else drawButton(buttonTwo, 30, 50, 350, 500, 150, buttonColor);
    
    if (isHovering(50, 525, 500, 150)) drawButton(buttonThree, 30, 50, 525, 500, 150, buttonColorHover);
    else drawButton(buttonThree, 30, 50, 525, 500, 150, buttonColor);
  }

  String onMouseClick() {
    if (isHovering(50, 350, 500, 150)) {
      return "albums";
    } else if (isHovering(50, 525, 500, 150)) {
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
