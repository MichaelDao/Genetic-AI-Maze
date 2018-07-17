// Will store our dot population
Population dotPop;

// the position of the target
PVector goal = new PVector(400, 10);

// basic setup
void setup()
{
  size(800, 800); // window size
  frameRate(60); // increase fps for faster dots
  dotPop = new Population(1000); // 1000 new dots
}

void draw()
{
  background(255); 

  // draw the goal
  fill(255, 0, 0);
  ellipse(goal.x, goal.y, 10, 10);

  // draw all the obstacles
  fill(0, 0, 255);
  rect(0, 300, 600, 10);

  // all dots have died
  if (dotPop.allDead()) 
  {
    //genetic algorithm
    dotPop.calculateFitness();
    dotPop.naturalSelection();
    dotPop.mutateNewPop();
  } 

  // some dots are still alive
  else 
  {
    //if any of the dots are still alive then update and then show them
    dotPop.update();
    dotPop.show();
  }
}
