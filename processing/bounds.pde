PVector test = this.position; //particle

    int i;
    int j;
    boolean result = false;
    if (c.size() != 0)
    {
     // for (int u = 0; u < c.size (); u++)
     // {
        result = false;
        
        Collidable Col = c.get(u); //shape
        ArrayList<PVector> Points = Col.Points;
        
        for (i = 0, j = Points.size () - 1; i < Points.size(); j = i++) {
          if ((Points.get(i).y > test.y) != (Points.get(j).y > test.y) &&
            (test.x < (Points.get(j).x - Points.get(i).x) * (test.y - Points.get(i).y) / (Points.get(j).y - Points.get(i).y) + Points.get(i).x)) {
            result = !result;  //if it's inside, then......
          }
        }
      }  
  }
