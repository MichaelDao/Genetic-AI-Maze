class Population
{
  // array of all our dots
  Dot[] dots;

  float fitnessSum;
  int gen = 1;
  int minStep = 1000;
  int bestDot = 0; // index of our best dot

  // Initialize with a population of size (e.g. 1000)
  Population(int size)
  {
    // initialize our population array
    dots = new Dot[size];

    // Initialize all our dots
    for (int x = 0; x < size; x++)
      dots[x] = new Dot();
  }

  // show all our dots
  void show() 
  {
    // start form the second index
    for (int x = 1; x < dots.length; x++) 
    {
      dots[x].show();
    }
    dots[0].show();
  }

  // update all dots
  void update()
  {
    for (int x = 0; x < dots.length; x++)
    {
      // if this dot has already taken more steps 
      // than the best dot to reach the goal, terminate it
      if (dots[x].brain.step > minStep)
      {
        dots[x].dead = true; // do it
      }

      // dot is currently fine
      else
      {
        dots[x].update();
      }
    }
  }



  boolean allDead()
  {
    // loop through all dots to check if they have all died 
    // or if one has reached the goal
    for (int x = 0; x < dots.length; x++)
      if (dots[x].dead == false && dots[x].reachGoal == false)
        return false;

    // all the dots are not alive
    return true;
  }
}
