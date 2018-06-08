// caliente: Aaron Li, Joan Chirinos, George Liang
// APCS2 pd8
// Final Project
// 06/08/18
import java.io.*;
import java.util.Scanner;

class Backend {
  
  // Variables 
  boolean shuffle; // state of shuffling
  boolean repeat; // state of repeating
  boolean pause; // state of pause

  //Creates a new .csv file to store files, and creates an album.csv file to store all album names 
  void makeAlbum(String inp) {
    int d = day();
    int m = month();
    int y = year();
    int hr = hour();
    int min = minute();  
    String csvName = inp + ".csv";
    File file = new File(csvName);
    File albumFile = new File("album.csv");
    if (! albumFile.exists()) { // checks of album.csv exists, if not, create it 
      try {
        FileWriter newAlbumFile = new FileWriter("album.csv");
        newAlbumFile.close();
      }
      catch(IOException e) {        
        println("Error: Failed to create album.csv");
      }
    }
    if ( file.exists()) {
      println("Error: File Already Exists");
    } else { // if album.csv exists, just write to it the name album name
      try {
        FileWriter albumWriter = new FileWriter("album.csv", true);
        BufferedWriter aW = new BufferedWriter(albumWriter);
        FileWriter output = new FileWriter(csvName); //Create empty file with the file name
        aW.write(inp + "," + m + "/" + d + "/" + y + " " + hr + ":" + min + ",0" + "\n" );
        aW.close();
        output.close();
      }
      catch (IOException e) {
        println("It Broke");
        e.printStackTrace();
      }
    }
  }

  //Return an ArrayList filled with urls from a csv file
  ArrayList<String> getAL(String albumName) {
    albumName += ".csv"; // file extensino
    ArrayList<String> album = new ArrayList<String>(); // arraylist to return
    File csv = new File(albumName); 
    if (! csv.exists()) { // checks if file exists
      println("Error: File Does Not Exist");
      return album;
    } else { // use Scanner to read and split urls, since it is all on one line
      Scanner inputStream = new Scanner(albumName);
      while (inputStream.hasNext()) {
        String line = inputStream.next();
        String[] urls = line.split(",");
        for (String url : urls) {
          album.add(url);
        }
      }
      inputStream.close();
    }   
    return album;
  }

  //Adds an image by url
  void add(String url, String albumName) {
    File f = new File(albumName);
    if (! f.exists()) { // checks for file existence
      println("Error: Input File does not exist");
      return;
    } else { // if file exists, just add new url to appropriate csv file
      try {
        FileWriter fw = new FileWriter(albumName, true);
        fw.write(url + ",");
        fw.close();
      }
      catch(IOException e) {
        println("Error");
      }
    }
  }

  //Deletes an image from an album by parsing through a csv and recopying over urls not equal to the one in parameter
  void delete(String url, String albumName) {
    ArrayList<String> newAlbum = new ArrayList<String>();
    File f = new File(albumName);
    if (! f.exists()) {
      println("Error: File Does Not Exist");
    } else {
      Scanner inputStream = new Scanner(albumName);
      while (inputStream.hasNext()) {
        String line = inputStream.next();
        String[] urls = line.split(",");
        for (String x : urls) {
          if (! x.equals(url)) {
            newAlbum.add(url);
          }
        }
      }
      inputStream.close();
      try {
        FileWriter writer = new FileWriter(albumName);
        BufferedWriter output = new BufferedWriter(writer);
        for (int i = 0; i < newAlbum.size(); i++) {
          output.write(newAlbum.get(i) + ",");
        }
        output.close();
      }
      catch(IOException e) {
        println("Deletion Error");
      }
    }
  }

  // Plays album slideshow. Each time shuffle/repeat is clicked, play will be invoked again
  void play(ArrayList<String> inp) {
    int size = inp.size(); // number of images
    ArrayList<String> temp = clone(inp); // make a copy of input without modifying it
    ArrayList<String> shuf = new ArrayList<String>(); // temporary arraylist to store random elements
    int counter = 0; // counter for when to play a random song

    if (pause == false) { // if pause state is false, then proceed to methods
      if (shuffle && repeat) { 
        while (shuffle && repeat) { // if both shuffle and repeat are toggled
          int rand = (int) (Math.random() * size + 1); // random integer in the range of 0 - input arraylist size
          int rand2 = (int) (Math.random() * shuf.size() + 1); // random integer in the range of 0 - shuffled arraylist size
          if (counter % (int) (size * 0.1) == 0) {
            displayImage(shuf.get(0));
            delay(3000);
            temp.add(rand, shuf.remove(0));
          } else {
            displayImage(temp.get(0));
            delay(3000);
            shuf.add(rand2, temp.remove(0));
          }
          counter++;
        }
      } else if (shuffle) { // if shuffled is toggled
        temp = clone(inp);
        shuf = new ArrayList<String>();
        int rand = (int) (Math.random() * size + 1); // random integer in the range of 0 - input arraylist size
        int rand2 = (int) (Math.random() * shuf.size() + 1); // random integer in the range of 0 - shuffled arraylist size
        for (int i = 0; i < size; i++) {
          shuf.add(rand2, temp.remove(rand));
        } 
        while (shuf.size() >= 0) {
          displayImage(shuf.get(0));
          delay(3000);
          shuf.remove(0);
        }
      } else if (repeat) { // if repeat is toggled
        temp = clone(inp);
        while (repeat) {
          displayImage(temp.get(0));
          delay(3000);
          temp.add(temp.remove(0));
        }
      } else { // if nothing is toggled, simply play through album and be done
        temp = clone(inp);
        while (temp.size() >= 0) {
          displayImage(temp.get(0));
          delay(3000);
          temp.remove(0);
        }
      }
    }
  }

  // Clones an arraylist without modifying original
  ArrayList<String> clone(ArrayList<String> inp) {
    ArrayList<String> temp = new ArrayList<String>();
    for (String i : inp) temp.add(i);
    return temp;
  }
  //Skips to next image in album
  void skip() {
  }

  //Skips to previous image in album
  void prev() {
  }

  //Displays image in the image screen given the img's url
  void displayImage(String url) {
    PImage img = loadImage(url);
    image(img, 0, 0, 600, 800);
  }

  //Plays the slideshow in the album by following Deque order
}
