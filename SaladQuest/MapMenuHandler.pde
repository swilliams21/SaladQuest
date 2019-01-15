public class MapMenuHandler implements commandable
{
   int menuMapX = 0, menuMapY = 0;
   ArrayList<LevelIndex> levelIndexes;
   LevelIndex currentLevel;
   String zone = "TestZone"; //Leave this as a default for errors. Actual zone should be loaded in. If the load fails, this will be the zone.
   PImage menuMap = loadImage("Zone/TestZone/Map.gif"); //Same as a above ^^^
   
   public void importLevelindex(String filename)
   {
     
     levelIndexes = new ArrayList<LevelIndex>();
     try{
     BufferedReader scan = createReader(filename);
     String aaa;
     aaa = scan.readLine();
     while(aaa != null)
     {
       levelIndexes.add(new LevelIndex(aaa));
       aaa = scan.readLine();
     }
     scan.close();
     if(currentLevel==null)
       {
         currentLevel=levelIndexes.get(0);
         levelIndexes.get(0).setSelected(true);
       }
     }catch(Exception E){exit();}
   }
   
   public LevelIndex getCurrentLevel()
   {
     return currentLevel;
   }
   
   public void setCurrentLevel(int i)
   {
     currentLevel.setSelected(false);
     currentLevel=levelIndexes.get(i);
     currentLevel.setSelected(true);
     zone=currentLevel.getZone();
     menuMap = loadImage("Zone/"+zone+"/Map.gif");
     displayMapMenu();
   }
   
   private void attemptMove(char a)
   {
    try
    {
      boolean check = true;
      int index = -1, index2;
      for(int i = 0; i < currentLevel.getExitSize(); i++)
      {
        if(currentLevel.getExitLetter(i)==a){index=i;}
      }
      if(index!=-1)
      {
        index2=currentLevel.getExitID(index);
        for(int i = 0; i < levelIndexes.size()&&check; i++)
        {
          if(levelIndexes.get(i).getID()==index2)
          {
            check=false;
            if(!levelIndexes.get(i).getLocked()){setCurrentLevel(i);}
          }
        }
      } 
    }catch(Exception E){}
   }
   
   public void key(char a)
   {
     attemptMove(a);
   }
   
   public void displayMapMenu()
  {
    background(0);
     menuMapX = currentLevel.getX();
     menuMapY = currentLevel.getY();
    if(menuMapX<512){menuMapX=512;}
    else if(menuMapX>1536){menuMapX=1536;}
    if(menuMapY<256){menuMapY=256;}
    else if(menuMapY>768){menuMapY=768;} // Min and max XY locations.
    
    image(menuMap,-menuMapX+512,-menuMapY+256);//update later to adjuster loaded from file
    /*if(levelIndexes==null)
    {rect(50,50,50,50);}*/
    /*if(levelIndexes.size()==0)
    {rect(50,50,50,50);}*/
    
    
    for(int i = 0; i < levelIndexes.size(); i++)
    {
      if(levelIndexes.get(i).getZone().matches(zone))
      {
        levelIndexes.get(i).display(menuMapX,menuMapY);
      }
    }
    
    fill(150);//shade of gray
    rect(900,350,200,50);
    rect(900,400,200,50);
    rect(900,450,200,50);
    fill(0);
    textSize(24);
    text("Enter Level",840,362);
    text("Save Menu",840,412);
    text("Main Menu",840,462);
  }
  @Override
  void processCommand()
  {
    
  }
}
