class Main {
  
  final color backgroundColor = color(226, 237, 255);
  final color buttonColor = color(255, 163, 163);
  final color buttonColorHover = color(255, 209, 209);

  //Main Screen

  void setup() {
    
  }

  void drawOne() {
    background(backgroundColor);
    fill(buttonColor);
    if (mouseX >= 50 && mouseX <= 550 && mouseY >= 75 && mouseY <= 275) {
      fill(buttonColorHover);
    }
    rect(50, 75, 500, 200);
    fill(buttonColor);
    if (mouseX >= 50 & mouseX <= 550 && mouseY >= 300 && mouseY <= 500) {
      fill(buttonColorHover);
    }
    rect(50, 300, 500, 200);
    fill(buttonColor);
    if (mouseX >= 50 && mouseX <= 550 && mouseY >= 525 && mouseY <= 725) {
      fill(buttonColorHover);
    }
    rect(50, 525, 500, 200);
  }
  
  String onMouseClick() {
    return "";
  }
}
