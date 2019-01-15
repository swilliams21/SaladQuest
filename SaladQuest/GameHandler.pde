//From an MVC point of view, this class acts like a Central "Model" and has Functions of a View

public class GameHandler implements commandable
{
  String mode;
  MapMenuHandler MMH = new MapMenuHandler();
  Level LL = null;
  Player player;

  public void displayMainMenu()
  {
    //artist and UI people draw here
    background(100);//this can be replaced with an image file later
    stroke(0);//black
    fill(150);//shade of gray
    rect(256,400,200,50);
    rect(512,400,200,50);
    rect(768,400,200,50);
    fill(0);
    textSize(24);
    text("New Game",200,410);
    text("Load Game",450,410);
    text("Exit",740,410);
  }

  
  public void LoadGame(String fileLocation)
  {
  MMH.importLevelindex(fileLocation+"/Levels.txt");
  player = new Player(fileLocation+"/Player.txt", 0, 0);
  mode("Map Menu");
  }
  
  String mode(){return mode;}
  void mode(String m){
    mode=m;
    if(m.equals("Main Menu"))
    {
      displayMainMenu();
    }
    else if(m.equals("Map Menu"))
    {
      //try{MMH.importLevelindex("Zone/TestZone/Levels.txt");}//CHANGE THIS TO CURRENT GAME LATER
      //catch(Exception E){}
      MMH.displayMapMenu();
    }
    if(m.equals("Level"))
    {
      int i = MMH.getCurrentLevel().getID();
      String level = ""+i;
      LL = new Level(level, player);
      background(100);
    }
  }
  void key(char a)
    {
      if(mode.equals("Map Menu")){MMH.key(a);}
      else if(mode.equals("Level")){LL.key(a);}
    }
  void noKey(char a)
    { 
      if(mode.equals("Level")){LL.noKey(a);}
    }
  void tick()
    {
      if (mode.equals("Level"))
      {
        LL.update();
        LL.display();
      }
    }
  @Override
  void processCommand()
  {
    
  }
}
