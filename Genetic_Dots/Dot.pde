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
    position = new PVector(width/2, height- 10);
    velocity = new PVector();
    acceleration = new PVector();
  }

  // draw dots
  void show()
  {
    // if this dot is the best, draw as bigger green dot
    if (isBest) 
    {
      fill(0, 255, 0);
      ellipse(position.x, position.y, 16, 16);
    } 

    // just your average dot
    else 
    {
      fill(0);
      ellipse(position.x, position.y, 4, 4);
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
      if (position.x < 2 || position.y < 2 ||
        position.x > width-2 || position.y > height -2) 
      {
        dead = true;
      } 

      // if the dot has hit an obstacle, then kill it
      else if (position.x< 600 && position.y < 310 && 
        position.x > 0 && position.y > 300) 
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
}
