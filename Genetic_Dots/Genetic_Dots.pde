Population dotPop; // Will store our dot population
PVector goal = new PVector(450, 10);// the position of the target
PFont font;

// basic setup
void setup()
{
  size(900, 700); // window size
  font = createFont("Arial", 16, true); 
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
  rect(0, 300, 600, 20); // obst 1

  fill(0, 0, 255);
  rect(200, 500, 800, 20);


  // draw the text
  textFont(font);       
  fill(0);
  textAlign(CENTER);
  text("Generation: " + dotPop.gen, width/2, 80); 
  text("Minimum steps: " + dotPop.minStep, width/2, 60); 
  text("Living dots: " + dotPop.livePopCount(), width/2, 40); 

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
