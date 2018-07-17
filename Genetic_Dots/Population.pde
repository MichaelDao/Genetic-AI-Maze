class Population
{
  // array of all our dots
  Dot[] dots;
  float fitnessSum;
  int gen = 1;
  int minStep = 1000;
  int bestDot = 0; // index of our best dot
  int livePop = 0;

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
      // if this dot has already taken more steps than the best dot to reach the goal, terminate it
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

  // check to see if all dots have died
  boolean allDead()
  {
    // loop through all dots to check if they have all died or if one has reached the goal
    for (int x = 0; x < dots.length; x++)
      if (dots[x].dead == false && dots[x].reachGoal == false)
        return false;

    // all the dots are not alive
    return true;
  }

  //calculate the fitness of each dot
  void calculateFitness() 
  {
    for (int x = 0; x < dots.length; x++)
      dots[x].calculateFitness();
  }

  // tally up the total overall fitness of all dots
  void calculateFitnessSum()
  {
    fitnessSum = 0;
    for (int x = 0; x < dots.length; x++)
      fitnessSum += dots[x].fitness;
  }

  // select the best dots for the next generation in our main genetic algorithm
  void naturalSelection()
  {
    Dot[] newDots = new Dot[dots.length]; // next generation

    // figure out the best dot by fitness
    setBestDot();

    // tally up the total overall fitness of the dot array
    calculateFitnessSum();

    // set the first dot in the array as the best dot
    newDots[0] = dots[bestDot].newBaby();
    newDots[0].isBest = true;

    // generate new array with new selected dots
    for (int x = 1; x < newDots.length; x++)
    {
      Dot parent = selectParent();
      newDots[x] = parent.newBaby();
    }

    dots = newDots.clone();
    gen++; // increment generation
  }

  // figure out which dot is the best by its highest fitness
  void setBestDot()
  {
    float max = 0; // max fitness
    int maxIndex = 0; 

    // linear search through array to find best dot
    for (int x = 0; x < dots.length; x++)
    {
      if (dots[x].fitness > max)
      {
        max = dots[x].fitness;
        maxIndex = x;
      }
    }

    // we got our best dot
    bestDot = maxIndex;

    // set minimum number of steps to best dots steps
    if (dots[bestDot].reachGoal)
    {
      minStep = dots[bestDot].brain.step;
    }
  }

  // choose a dot from the population randomly (considering fitness)
  // This is done by choosing a random value between 0 and the highest fitness sum
  // and selecting a group of dots before the running total exceeds the random sum
  Dot selectParent()
  {
    float rand = random(fitnessSum);
    float runningSum = 0;

    // total up the running sum
    for (int x = 0; x < dots.length; x++)
    {
      runningSum += dots[x].fitness;

      // stop as soon as we exceed the random number
      if (runningSum > rand)
        return dots[x];
    }

    // should never reach here
    return null;
  }

  //mutates all the brains of the babies
  void mutateNewPop() 
  {
    for (int x = 1; x < dots.length; x++) 
      dots[x].brain.mutate();
  }

  // count total of living dots
  int livePopCount()
  {
    livePop = 0;
    for (int x = 1; x < dots.length; x++) 
      if (!dots[x].dead)
        livePop++;

    return livePop;
  }
}
