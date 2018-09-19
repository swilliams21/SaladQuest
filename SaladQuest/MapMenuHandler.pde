public class MapMenuHandler
{
   int menuMapX = 0, menuMapY = 0;
   ArrayList<LevelIndex> levelIndexes; 
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
     }catch(Exception E){exit();}
   }



   public void displayMapMenu()
  {
    //artist and UI people draw here//if anybody want to implement a custom drawn map, feel free
    background(0);
    
    if(menuMapX<512){menuMapX=512;}
    else if(menuMapX>1536){menuMapX=1536;}
    if(menuMapY<256){menuMapY=256;}
    else if(menuMapY>768){menuMapY=768;} // Min and max XY locations.
    
    image(menuMap,menuMapX-512,menuMapY-256);
    /*if(levelIndexes==null)
    {rect(50,50,50,50);}*/
    /*if(levelIndexes.size()==0)
    {rect(50,50,50,50);}*/
    
    
    for(int i = 0; i < levelIndexes.size(); i++)
    {
      levelIndexes.get(i).display(menuMapX,menuMapY);
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
}
