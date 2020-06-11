void fadeLineFromImg(float x1, float y1, float x2, float y2){
  int xOffset = floor(abs(x1 - x2));
  int yOffset = floor(abs(y1 - y2));
  int step = xOffset < yOffset ? yOffset : xOffset;
  for (int i = 0 ; i < step ; i++) {
    int x = floor(x1 + (x2 - x1) * i / step);
    int y = floor(y1 + (y2 - y1) * i / step);
    color originColor = color(red(getColor(x, y)), green(getColor(x, y)), blue(getColor(x, y)), alpha(getColor(x, y)));

    float r = red(originColor);
    float g = green(originColor);
    float b = blue(originColor);
    
    originColor = color(r + 50 > 255 ? 255 : (r + 50), g + 50 > 255 ? 255 : (g + 50), b + 50 > 255 ? 255 : (b + 50));

    setColor(x, y, originColor);
  }
}

color getColor(int i, int j) {
  int index = j * myImage.width + i;
  return color(red(myImage.pixels[index]), green(myImage.pixels[index]), blue(myImage.pixels[index]), alpha(myImage.pixels[index]));
}

void setColor(int i, int j, color c) {
  int index = j * myImage.width + i;
  myImage.pixels[index] = color(red(c), green(c), blue(c), alpha(c));
}
