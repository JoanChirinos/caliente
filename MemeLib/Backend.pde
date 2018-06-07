// caliente: Aaron Li, Joan Chirinos, George Liang
// APCS2 pd8
// Final Project
// 06/02/18
import java.io.*;
import java.util.Scanner;

class Backend {
  boolean shuffle;
  boolean repeat;


  //Creates a new .csv file to store files 
  void makeAlbum(String inp) {
    int d = day();
    int m = month();
    int y = year();
    int hr = hour();
    int min = minute();
    File file = new File(inp + d + m + y + hr + min);
    if ( file.exists()) {
       println("Error: File Already Exists");
    } else {
      FileWriter output = null;
      try {
        output = new FileWriter(file); //Create empty file with the file name
        output.write("");
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

  //Return an ArrayList filled with urls from a csv file
  ArrayList<String> getAL(String albumName) {
    ArrayList<String> album = new ArrayList<String>();
    File csv = new File(albumName);
    if (! csv.exists()) {
      println("Error: File Does Not Exist");
      return album;
    } else {
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
  void add(String url, String csvFile) {
    File f = new File(csvFile);
    if (! f.exists()) {
      println("Error: Input File does not exist");
      return;
    } else {
      try {
        FileWriter fw = new FileWriter(csvFile, true);
        BufferedWriter output = new BufferedWriter(fw);
        output.write(url + ",");
        output.close();
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
      try{
        FileWriter writer = new FileWriter(albumName);
        BufferedWriter output = new BufferedWriter(writer);
        for(int i = 0; i < newAlbum.size(); i++){
          output.write(newAlbum.get(i) + ",");
        }
        output.close();
      }
      catch(IOException e){
        println("Deletion Error");
      }
    }
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
}
