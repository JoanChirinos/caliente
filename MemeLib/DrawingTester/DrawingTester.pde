String filename;
String nameBefore;

void setup(){
  size(500,500);
  background(0);
}

void draw(){
  if (keyPressed){
    //Type Shift + s to save sketch as newpic.jpg
    if (key == 'S'){
      save("newpic.jpg");
    }
    //Type Shift + c to clear sketch
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
