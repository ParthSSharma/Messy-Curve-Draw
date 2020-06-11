PImage myImage;
int numSteps = 300, counter = 0;
float zFactor = 0;
Canvas myCanvas;

void setup() {
  size(600, 332);
  PImage imageToDraw = loadImage("Mahabharat.jpg");
  myImage = createImage(width, height, RGB);
  
  myCanvas = new Canvas(new PVector(0, 0));
  noFill();
  myImage.copy(imageToDraw, 0, 0, imageToDraw.width, imageToDraw.height, 0, 0, myImage.width, myImage.height);
  myImage.loadPixels();
  background(255);
}

void draw() {
  for (int i = 0; i < numSteps; i++) {
    myCanvas.update();
    myCanvas.show();
    zFactor += 0.01;
  } 
  //saveFrame("Images/####.png");
  if(frameCount == 1000){
    noLoop();
  }
}
