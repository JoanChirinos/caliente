import java.awt.datatransfer.*;
import java.awt.Toolkit; 

class NewImage {

  final color backgroundColor = color(226, 237, 255);
  final color buttonColor = color(255, 163, 163);
  final color buttonColorHover = color(255, 209, 209);
  final color textColor = color(0, 0, 0);
  final color white = color(255, 255, 255);

  boolean hasSetUpAlready = false;

  int keyPressDelay;

  String currentURL;

  String currentCSV = "";

  Backend b;

  void setup() {
    if (!hasSetUpAlready) {
      background(backgroundColor);
      textAlign(CENTER, CENTER);

      currentURL = "";

      keyPressDelay = 7;
      b = new Backend();

      hasSetUpAlready = true;
    }
  }

  void drawOne() {
    drawText("New image URL", 30, 50, 50, 500, 50);
    textAlign(LEFT, TOP);
    drawButton(currentURL, 35, 50, 110, 500, 100, white);
    textAlign(CENTER, CENTER);

    if (isHovering(350, 325, 100, 50)) drawButton("Okay", 30, 350, 325, 100, 50, color(220, 220, 220));
    else drawButton("Okay", 30, 350, 325, 100, 50, white);

    drawText("Enter the word \"paste\" to paste from your clipboard", 15, 50, 285, 500, 50);

    if (currentURL.equals("paste")) {
      ClipHelper cp = new ClipHelper();
      currentURL = cp.pasteString();
      cp = null;
    }

    if (keyPressed) {
      keyPressDelay--;
    }

    if (keyPressDelay == 0 && keyPressed) {
      keyPressDelay = 7;
      char k = key;

      if (k == BACKSPACE) {
        if (currentURL.length() > 0) currentURL = currentURL.substring(0, currentURL.length() - 1);
      } else if (currentURL.length() <= 30 && (Character.isLetter(k) || Character.isDigit(k))) {
        currentURL += key;
      }
    } else if (keyPressDelay > 1) {
      keyPressDelay--;
      println(keyPressDelay);
    }
  }

  String onMouseClick() {
    if (isHovering(350, 325, 100, 50) && !currentURL.equals("")) {
      println("current csv: " + currentCSV + "\ncurrentURL: " + currentURL);
      b.add(currentURL, currentCSV);
      println("clicked");
      hasSetUpAlready = false;
      return currentURL;
    } else  return "";
  }

  void setCSV(String newCSV) {
    currentCSV = newCSV;
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

// CLIPHELPER OBJECT CLASS:

class ClipHelper {
  Clipboard clipboard;

  ClipHelper() {
    getClipboard();
  }

  void getClipboard () {
    // this is our simple thread that grabs the clipboard
    Thread clipThread = new Thread() {
      public void run() {
        clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
      }
    };

    // start the thread as a daemon thread and wait for it to die
    if (clipboard == null) {
      try {
        clipThread.setDaemon(true);
        clipThread.start();
        clipThread.join();
      }  
      catch (Exception e) {
      }
    }
  }

  void copyString (String data) {
    copyTransferableObject(new StringSelection(data));
  }

  void copyTransferableObject (Transferable contents) {
    getClipboard();
    clipboard.setContents(contents, null);
  }

  String pasteString () {
    String data = null;
    try {
      data = (String)pasteObject(DataFlavor.stringFlavor);
    }  
    catch (Exception e) {
      System.err.println("Error getting String from clipboard: " + e);
    }
    return data;
  }

  Object pasteObject (DataFlavor flavor)  
    throws UnsupportedFlavorException, IOException
  {
    Object obj = null;
    getClipboard();

    Transferable content = clipboard.getContents(null);
    if (content != null)
      obj = content.getTransferData(flavor);

    return obj;
  }
}
