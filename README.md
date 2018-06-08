# caliente: Joan Chirinos, George Liang, Aaron Li
# Project Name: MemeLib
# Project Description
Our team hopes to make a functional image/meme library with most, if not all, all the functions of a typical photo viewer/gallery. This includes but is not limited to:
* Play/Pause button that plays/stops playing a slideshow of images/memes
* Skip next/previous button that goes to view the next or previous image
* Functionality to create albums of selected images
* Ability to search for image files by name, import and export image files
* storage of image files on a server(homer xd)
* Shuffle and repeat image slideshows

# Project Highlights

### Reinforce
Our project will implement data structures taught during the APCS course, such as ArrayLists and/or doubly-linked lists in order to store image albums. We will need an algorithm to order to play/shuffle random images, and also for adding a repeat functionality.

### Showcase
Our project will entail making a GUI/functional UI for the user in order to click buttons and function. This will be done using Java Swing/GUI. If this proves to be too difficult, we will try to implement an UI with a different approach.

### Extend
Our project requires us to gather large amounts of image files, and we will need to learn how to use Java Swing to implement the UI.

# How It Works
Our project uses Processing to create a UI in which a user can click designated buttons which have the function of doing the task illustrated in the project description. We use mouseClick() in conjunction with the coordinate system of the window to determine where the user clicks and thus which functionality to procure. In the backend, our project uses Deques as means of create albums and adding images to an album. Each album is a separate Deque, and when clicked play, it will start from the beginning and goes to the end. Shuffle/repeat are toggles that switch the order of and repeat the iterance of that designated Deque. We use another class(not yet fully explored) to implement importing and exporting of images. Additionally, we will have a draw and export functionality with will use Processing to draw an image by using the coordinates of the window and draw(), which we will then allow the exportation of.

# Launch Instructions
1) Run the program in the respective folder for your computer type (we will figure that out on our school computers tomorrow)
2) The buttons are self explanatory
   * From the main screen, you can either view all images, load the album selector, or exit
   * From the album selector screen, you may select an album, go to the next/previous page of albums, or go back. Upon selection, you will be taken to the view screen
   * From the view screen, you can draw on the current image, you can save the image to your computer, add a new image to the current album, go back to the main screen, go to the next/previous image in the queue, shuffle the image queue, or start/stop the slideshow
