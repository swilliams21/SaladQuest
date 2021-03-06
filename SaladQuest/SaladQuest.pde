
//from an MVC point of view this class acts as a Controller and Initiailizer

GameHandler gh;
BogScriptHandler bsh; 
void setup()//Prexisting method in processing. It will be used for initial load.
{
  bsh = new BSHSingleton().getBogScriptHandler();
  gh = new GameHandler();
  bsh.setGameHandler(gh);
  size(1024,512);
  rectMode(CENTER);
  textMode(CENTER);
  gh.mode("Main Menu");
  frameRate(20);
}

void draw()//Prexisting method in processing. It will be used as an updater.
{
  gh.tick();
  //time based updater method
}

void mouseClicked()// Prexisting method in processing. It will be used for clicking on buttons or dialogue.
{
  if(gh.mode().equals("Main Menu"))//Main Menu Code//Click Coordinates and actions
  {
    if((mouseY>375&&mouseY<425)&&(mouseX>156&&mouseX<356))//New Game
    {
      gh.LoadGame("NewGame");
      gh.mode("Map Menu");
    }
    else if((mouseY>375&&mouseY<425)&&(mouseX>412&&mouseX<612))//Button 2
    {
      fill(0,255,0);rect(50,50,50,50);//test code. Delete when replaced
    }
    else if((mouseY>375&&mouseY<425)&&(mouseX>668&&mouseX<868))//Exit
    {
      exit();
    }    
    
  }
    if(gh.mode().equals("Map Menu"))//Main Menu Code//Click Coordinates and actions
  {
    if((mouseY>325&&mouseY<375)&&(mouseX>800&&mouseX<1000))//New Game
    {
      gh.mode("Level");
    }
    else if((mouseY>375&&mouseY<425)&&(mouseX>800&&mouseX<1000))//Button 2
    {
      gh.mode("Save Menu");
    }
    else if((mouseY>425&&mouseY<475)&&(mouseX>800&&mouseX<1000))//Exit
    {
      gh.mode("Main Menu");
    }    
    
  }
}

void keyPressed()//Prexisting method in processing. It will be used for game controls.
{gh.key(Character.toLowerCase(key));}
void keyReleased()//Prexisting method in processing. It will be used for game controls.
{gh.noKey(Character.toLowerCase(key));}
