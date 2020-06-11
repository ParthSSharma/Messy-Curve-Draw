class Canvas{
  PVector previousPos, currentPos, velocity = new PVector(0, 0), force = new PVector(0, 0);
  float maxSpeed = 1.3, surroundMatrix = 3, noiseMultiplier = 1 / 10.0;
  int drawAlpha = 30, drawWeight = 1, maxCounter = 70;
  color drawColor = color(0, 0, 0, drawAlpha);
  
  Canvas(PVector pos){
    previousPos = pos.copy();
    currentPos = pos.copy();
  }
  
  void update(){
    previousPos = currentPos.copy();
    force.mult(0);
    
    PVector target = new PVector(0, 0);
    counter = 0;
    for(float i = -floor(surroundMatrix / 2); i < surroundMatrix / 2; i++){
      for(float j = -floor(surroundMatrix / 2); j < surroundMatrix / 2; j++){
        if (i == 0 && j == 0){
          continue;
        }
        int x = floor(currentPos.x + i);
        int y = floor(currentPos.y + j);
        if(((myImage.width - 1 - x) | (x - 0) | (myImage.height - 1 - y) | (y - 0)) >= 0){
          color c = color(red(getColor(x, y)), green(getColor(x, y)), blue(getColor(x, y)), alpha(getColor(x, y)));
          //drawColor = color(red(c), green(c),
                      //blue(c), drawAlpha);
          float b = brightness(c); //Get pixel brighness
          b = 1 - b / 20.0;
          PVector pos = new PVector(i, j);
          target.add(pos.div(pos.mag()).copy().mult(b));
          counter++;
        }
      }
    }
    if(counter != 0){
      force.add(target.div(counter));
    }
    
    float n = noise(currentPos.x, currentPos.y, zFactor);
    n = map(n, 0, 1, 0, 5 * TWO_PI);
    PVector p = PVector.fromAngle(n); 
    if(force.mag() < 0.01){
      force.add(p.mult(noiseMultiplier * 5));
    }
    else{
      force.add(p.mult(noiseMultiplier));
    }

    velocity.add(force);
    if (velocity.mag() > maxSpeed) {
      velocity.normalize().mult(maxSpeed);
    }
    
    currentPos.add(velocity);
    if (!((floor(width - currentPos.x) | floor(currentPos.x - 0) | floor(height - currentPos.y) | floor(currentPos.y - 0)) >= 0)) {
      reset();
    }
  }
  
  void reset(){
    myImage.updatePixels();
    myImage.loadPixels();

    counter = 0;
    boolean hasFound = false;
    while(!hasFound){
      currentPos.x = random(1) * width;
      currentPos.y = random(1) * height;
      color c = color(red(getColor(floor(currentPos.x), floor(currentPos.y))), green(getColor(floor(currentPos.x), floor(currentPos.y))),
                      blue(getColor(floor(currentPos.x), floor(currentPos.y))), alpha(getColor(floor(currentPos.x), floor(currentPos.y))));
      float b = brightness(c);
      if(b < 255){
        hasFound = true;
      }
    }
    drawColor = color(red(getColor(floor(currentPos.x), floor(currentPos.y))), green(getColor(floor(currentPos.x), floor(currentPos.y))),
                      blue(getColor(floor(currentPos.x), floor(currentPos.y))), drawAlpha);
    previousPos = currentPos.copy();
    velocity.mult(0);
  }
  
  void show(){
    counter++;
    if(counter > maxCounter){
      reset();
    }
    stroke(drawColor);
    //drawColor = color(red(getColor(floor(currentPos.x), floor(currentPos.y))), green(getColor(floor(currentPos.x), floor(currentPos.y))),
                      //blue(getColor(floor(currentPos.x), floor(currentPos.y))), drawAlpha);
    strokeWeight(drawWeight);
    line(previousPos.x, previousPos.y, currentPos.x, currentPos.y);
    fadeLineFromImg(previousPos.x, previousPos.y, currentPos.x, currentPos.y);
  }
}
