
/*
Objectives of this class:
 
 1) generate a sample string
 2) calculate fitness
 3) crossover
 4) mutate
 */






class DNA {

  char[] gene;

  float fitness; 


  //generating sample size
  DNA(int num) {

    gene = new char[num];
    for (int i = 0; i < num; i++)
    {
      gene[i] = (char) random(32, 128);
    }
  }


  String getPhrase()
  {
    return new String(gene);
  }

  //calculating individual fitness 
  void fitness(String target)
  {
    int score = 0;
    for (int i = 0; i < gene.length; i++)
    {
      if (gene[i] == target.charAt(i))
      {
        score++;
      }
    }
    fitness = (float)score/(float)target.length();
  }

  //crossover

  DNA crossover(DNA partner)
  {
    //create a new child
    DNA child = new DNA(gene.length);

    int midpoint = int(random(gene.length));
    for (int i = 0; i < gene.length; i++)
    {
      if (i < midpoint) //takes half from one parent
        child.gene[i] = gene[i];
      else                //and half from the other 
      child.gene[i] = partner.gene[i];
    }

    return child;
  }

  //mutation 

  void mutate (float mutationRate) 
  {
    for (int i = 0; i < gene.length; i++)
    {
      if (random(1) < mutationRate)
      {
        gene[i] = (char) random(32, 128);
      }
    }
  }
}
