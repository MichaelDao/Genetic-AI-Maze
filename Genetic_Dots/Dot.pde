class Dot
{
  // PVector is a processing library that describes a 2D or 3D Vector.
  // PVector(x, y) --> x is the x-coord, y is the y-coord.
  PVector position, velocity, acceleration;
  Brain brain;
  boolean dead = false;
  boolean reachGoal = false;
  boolean isBest = false; // best dot from previous generation
  float fitness = 0;

  // Constructor
  Dot() 
  {
    brain = new Brain(1000); // new brain with 1000 instructions

    // initial position at bottom window with no velocity or acceleration
    position = new PVector(800, height-10);
    velocity = new PVector();
    acceleration = new PVector();
  }

  // draw dots
  void show()
  {
    // best dot
    if (isBest) 
    {
      fill(0, 255, 0);
      ellipse(position.x, position.y, 12, 12);
    } 

    // regular dot
    else 
    {
      if (dead)
      {
        fill(0);
      } else
      {
        fill(255, 0, 255);
      }
      ellipse(position.x, position.y, 8, 8);
    }
  }

  // update dot position
  void update()
  {
    // dot is not dead, or has not reached goal
    if (dead == false && reachGoal == false) 
    {
      // move dot
      move();

      // if dot is found near window edge, then kill it
      if (position.x < 2 || position.y < 2 || position.x > width - 2 || position.y > height - 2) 
      {
        dead = true;
      } 

      // dot encountered an obstacle
      else if (position.x < 600 && position.y < 320 && position.x > 0 && position.y > 300) 
      {
        dead = true;
      }

      // dot encountered an obstacle 2
      else if (position.x < 1000 && position.y < 520 && position.x > 200 && position.y > 500) 
      {
        dead = true;
      }
      
      // this dot has come into contact with the goal
      else if (dist(position.x, position.y, goal.x, goal.y) < 5) 
      {
        reachGoal = true;
      }
    }
  }

  // move according to the brains set of directions
  void move()
  {
    // there are still directions left, 
    // set acceleration as next vector in direction array
    if (brain.direction.length > brain.step)
    {
      acceleration = brain.direction[brain.step];
      brain.step++;
    }

    // if we are at the end of the direction array, dot is dead
    else 
    {
      dead = true;
    }

    //apply the acceleration and move the dot
    velocity.add(acceleration);
    velocity.limit(5); //not too fast
    position.add(velocity);
  }

  // calculate dot fitness
  void calculateFitness()
  {
    // calculate fitness based on amount of
    // steps it took to get there if goal reached
    if (reachGoal)
    {
      fitness = 1.0/16.0 + 10000.0/(float)(brain.step * brain.step);
    } 

    // calculate fitness based on how close it
    // is to the goal if it didnt reach it
    else
    {
      float distanceToGoal = dist(position.x, position.y, goal.x, goal.y);  
      fitness = 1.0/(distanceToGoal * distanceToGoal);
    }
  }

  Dot newBaby()
  {
    Dot baby = new Dot();
    // babies are the same as their parents
    baby.brain = brain.clone();
    return baby;
  }
}
