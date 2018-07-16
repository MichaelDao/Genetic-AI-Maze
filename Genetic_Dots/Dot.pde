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

  Dot() 
  {
    brain = new Brain(1000); // new brain with 1000 instructions

    // initial position at bottom window with no velocity or acceleration
    position = new PVector(width/2, height- 10);
    velocity = new PVector();
    acceleration = new PVector();
  }
}
