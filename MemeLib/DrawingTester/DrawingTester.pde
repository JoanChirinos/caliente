String filename;
String nameBefore;

void setup(){
  size(500,500);
  background(0);
}

void draw(){
  if (keyPressed){
    if (key == 'S'){
      save("newpic.jpg");
    }
    if (key == 'C'){
      background(0);
    }
  }
}

void mouseDragged(){
  stroke(255);
  ellipse(mouseX,mouseY,10,10);
  fill(255,255,255);
}
