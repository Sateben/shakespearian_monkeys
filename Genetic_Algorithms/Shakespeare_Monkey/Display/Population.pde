/*
Objectives of this class:
 
 1) generate a sample population
 2) determine their interactions with the each other 
 */



class Population {

  float mutationRate;  //determines the number of children who will be mutated to introduce some degree of diversity into the population 
  DNA[] population;    //population array to hold all the members 
  ArrayList<DNA> mating; //inside this arraylist, the crossover will take place
  String target;       // this is the target phrase 
  int generations;     //number of generations that take place 
  boolean finished;    // is the evolving done? 
  int perfectscore;    // target score to be achieved to decide if program has succeeded in it's intended purpose 


  Population(String target_phrase, float mutation_rate, int size_of_population)
  {
    target = target_phrase;
    mutationRate  = mutation_rate; 
    population = new DNA[size_of_population];

    for (int count = 0; count < population.length; count++)
    {
      population[count] = new DNA(target.length());
    }
    calculate_FITNESS();
    mating = new ArrayList<DNA>();
    generations = 0;
    finished = false;
    
    perfectscore = 1;
  }

  //provide a fitness calculation for every member of the population 

  void calculate_FITNESS()
  {
    for (int count = 0; count < population.length; count++)
    {
      population[count].fitness(target);
    }
  }

  //generate a mating pool 

  void naturalSelection()
  {
    //clear ArrayList
    mating.clear();

    float maxFitness = 0; 
    for (int count = 0; count < population.length; count++)
    {
      if (population[count].fitness > maxFitness)
        maxFitness = population[count].fitness;
    }

    //Based on fitness, each member will get added to the mating pool a certain number of times
    // a higher fitness = more entries to mating pool = more likely to be picked as a parent
    // a lower fitness = fewer entries to mating pool = less likely to be picked as a parent

    for (int count = 0; count < population.length; count++) {

      float fitness = map(population[count].fitness, 0, maxFitness, 0, 1);
      int n = int(fitness*100); //this is an arbitrary multiplier
      for (int count2 = 0; count2 < n; count2++)
      {
        mating.add(population[count]); // the number gets added as many times as it's %fitness
      }
    }
  }


  //create a new generation 

  void generate() {
    //fill the population from the mating pool with children 
    for (int count = 0; count < population.length; count++)
    {
      int randomnumber = int(random(mating.size()));
      int randomnumber_2 = int(random(mating.size())); 
      DNA partner_A = mating.get(randomnumber); 
      DNA partner_B = mating.get(randomnumber_2); 
      DNA child = partner_A.crossover(partner_B); 
      child.mutate(mutationRate); 
      population[count] = child;
    }

    generations++;  //increments the generation counter... so that user can see how many times this step had to be undertaken to achieve intended purpose
  }


  String getBest() {
    int index = 0; 
    float phrases_fitness = 0.0; 
    for (int count = 0; count < population.length; count++)
    {
      if (population[count].fitness > phrases_fitness)
      {
        phrases_fitness = population[count].fitness;

        index = count;
        
      }
    }
    
    if (int(phrases_fitness) == perfectscore)
        {
          System.out.println("phrases_fitness:"+phrases_fitness);
          finished = true; 
        }

    return population[index].getPhrase();
  }


  boolean finished() {
    return finished;
  }


  int getGenerations() {
    return generations;
  }


  // Compute average fitness for the population
  float getAverageFitness() {
    float total = 0;
    for (int i = 0; i < population.length; i++) {
      total += population[i].fitness;
    }
    return total / (population.length);
  }

  String allPhrases() {
    String everything = "";

    int displayLimit = min(population.length, 50);


    for (int i = 0; i < displayLimit; i++) {
      everything += population[i].getPhrase() + "\n";
    }
    return everything;
  }
}
