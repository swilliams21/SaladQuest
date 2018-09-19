//From an MVC point of view, this class acts like a Central Model and has Functions of a View

public class GameHandler{
  Boolean canMove = false;
  String mode;
  String zone = "TestZone"; //Leave this as a default for errors. Actual zone should be loaded in. If the load fails, this will be the zone.
  PImage menuMap = loadImage("Zone/TestZone/Map.gif"); //Same as a above ^^^
  int menuMapX = 0, menuMapY = 0;
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
  public void displayMapMenu()
  {
    //artist and UI people draw here//if anybody want to implement a custom drawn map, feel free
    background(0);
    
    if(menuMapX<512){menuMapX=512;}
    else if(menuMapX>1536){menuMapX=1536;}
    
    if(menuMapY<256){menuMapY=256;}
    else if(menuMapY>768){menuMapY=768;}
    
    image(menuMap,menuMapX-512,menuMapY-256);
    
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
  
  public void newGame()
  {
  mode("Map Menu");
  }
  
  Boolean canMove(){return canMove;}
  void canMove(boolean b){canMove=b;}
  String mode(){return mode;}
  void mode(String m){
    mode=m;
    if(m.equals("Main Menu"))
    {
      canMove(false);
      displayMainMenu();
    }
    else if(m.equals("Map Menu"))
    {
      canMove(true);
      displayMapMenu();
    }
  }
}
