# caliente: Joan Chirinos, George Liang, Aaron Li
# Project Name: MemeLib
# Project Description
Our team hopes to make a functional image/meme library with most, if not all, all the functions of a typical photo viewer/gallery. This includes but is not limited to:
* Play/Pause button that plays/stops playing a slideshow of images/memes
* Skip next/previous button that goes to view the next or previous image
* Functionality to create albums of selected images
* storage of image files as a csv of urls
* Shuffle and repeat image slideshows
* Ability to copy and paste the link of an image file online to add it to an album

# Project Highlights

### Reinforce
Our project will implement data structures taught during the APCS course, such as ArrayLists in order to store image albums. We will need an algorithm to order to play/shuffle random images, and also for adding a repeat functionality. We also implemented the use of a 
QuickSort algorithm in order to sort the album list by name order.

### Showcase
Our project will entail making a GUI/functional UI for the user in order to click buttons and function. This will be done using Processing. We will need to implement methods to draw boxes/attach functions when certain mouse buttons are clicked.

### Extend
Our project requires more extensive knowledge and practice of processing than what we have accomplished in class.

# How It Works
Our project uses Processing to create a UI in which a user can click designated buttons which have the function of doing the task illustrated in the project description. We use mouseClick() in conjunction with the coordinate system of the window to determine where the user clicks and thus which functionality to procure. In the backend, our project uses ArrayLists as means of create albums and adding images to an album. Each album is a separate csv of urls, and when play is clicked, it will start from the beginning and goes to the end. Shuffle/repeat are toggles that switch the order of and repeat the iterance of that designated ArrayList. We use another class called Backend.java to implement importing and exporting of images. Additionally, we will have a draw and export functionality with will use Processing to draw an image by using the coordinates of the window and draw(), which we will then allow the exportation of. One of the biggest extensions of our project involves the processing of files like csv files and working with a smooth UI that transitions per button pressed. We implement the usage of Java classes such as FileWriter and BufferedWriter in order to write and record user information to csv files in order to be able to pull it back up later.

# Launch Instructions
1) Open folder caliente/MemeLib/Main.pde in processing
2) Press play
3) The buttons are self explanatory
   * From the main screen, you can either load the album selector, or exit
   * From the album selector screen, you may select an album, go to the next/previous page of albums, add to an album or go back. Upon selection, you will be taken to the view screen.
   * From the view screen you will be able to go back to the main screen, shuffle the image queue, or start/stop the slideshow
