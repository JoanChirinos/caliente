// caliente: Aaron Li, Joan Chirinos, George Liang
// APCS2 pd8
// Final Project
// 06/02/18
import java.io.*;
import java.util.Scanner;

class Backend {
  boolean shuffle;
  boolean repeat;


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
        output.close()
      }
      catch(IOException e) {
        println("Error");
      }
    }
  }

  //Deletes an image from an album
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
