// caliente: Aaron Li, Joan Chirinos, George Liang
// APCS2 pd8
// Final Project
// 06/02/18

boolean shuffle;
boolean repeat;

import java.io.*;

//Creates a new .txt file to store files 
void makeAlbum(String inp) {
  File file = new File(sketchPath("album.csv"));
  int d = day();
  int m = month();
  int y = year();
  int hr = hour();
  int min = minute();
  if (! file.exists()) {
    PrintWriter output = createWriter("album.csv");
    output.println(inp + "," + m + "/" + d + "/" + y + " " + hr + ":" + min + ",0" + "\n");
    output.close();
  } else {
    FileWriter output = null;
    try {
      output = new FileWriter(file, true); //the true will append the new data
      output.write(inp + "," + m + "/" + d + "/" + y + " " + hr + ":" + min + ",0" + "\n");
    }
    catch (IOException e) {
      println("It Broke");
      e.printStackTrace();
    }
    finally {
      if (output != null) {
        try {
          output.close();
        } 
        catch (IOException e) {
          println("Error while closing the writer");
        }
      }
    }
  }
}


//Adds an image by url
PImage add(String url) {
  PImage meme;
  meme = loadImage(url);
  return meme;
}

//Deletes an image from an album
void delete() {
}

//Skips to next image in album
void skip() {
}

//Skips to previous image in album
void prev() {
}

//Displays image in the image screen
void displayImage() {
}

//Plays the slideshow in the album by following Deque order
