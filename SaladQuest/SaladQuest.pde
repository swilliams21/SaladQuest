import java.util.Scanner;
import java.io.*;
GameHandler gh;
void setup()//Prexisting method in processing. It will be used for initial load.
{
  gh = new GameHandler();
  size(1024,512);
  rectMode(CENTER);
  
  gh.mode("Main Menu");
  
}

void draw()//Prexisting method in processing. It will be used as an updater.
{
  //time based updater method
  
  
}

void mouseClicked()// Prexisting method in processing. It will be used for clicking on buttons or dialogue.
{
  if(gh.mode().equals("Main Menu"))//Main Menu Code//Click Coordinates and actions
  {
    if((mouseY>0&&mouseY<100)&&(mouseX>0&&mouseX<100))//New Game
    {
      
    }
  }
  
}

void keyPressed()//Prexisting method in processing. It will be used for game controls.
{
  //movement
  if(gh.canMove())//change later for handler.canMove()//boolean
  {
  if(key == 'a'){}
  else if(key == 'd')
  {}
  else if(key == 'w')
  {}
  else if(key == 's')
  {}
  //other controls
  else if(key == 'f')
  {}
  //numbers
  else if(key == '1')
  {}
  
  }
}
