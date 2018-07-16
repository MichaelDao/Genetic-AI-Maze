class Brain
{
  // the series of vectors (positions) which get the dot to the goal
  PVector[] direction; 

  // for the update() method from Population
  int step = 0;

  Brain(int size)
  {
    // initialize direction array
    direction = new PVector[size];
    randomize();
  }

  // Set the direction to a random angle with length 1.
  void randomize()
  {
    // iterate through each individual dot
    for (int x = 0; x < direction.length; x++)
    {
      // generate a random angle for the direction
      float randomAngle = random(2*PI);
      direction[x] = PVector.fromAngle(randomAngle);
    }
  }

  // create a copy of this brain object
  Brain clone()
  {
    // new brain object that holds existing series of directions
    Brain clone = new Brain(direction.length);

    // for each individual driection, copy into the new brain
    for (int x = 0; x < direction.length; x++)
      clone.direction[x] = direction[x].copy();

    // return the copy
    return clone;
  }

  void mutate()
  {
    // 10% percent chance of any vector in direction mutating
    float mutationRate = 0.01; 

    for (int x = 0; x <direction.length; x++)
    {
      float rand = random(1); // random value out of 100% 

      // we have hit our 10% chance of mutation
      if (rand < mutationRate)
      {
        // generate a random angle for the direction
        float randomAngle = random(2*PI);
        direction[x] = PVector.fromAngle(randomAngle);
      }
    }
  }
}
