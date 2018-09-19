//From an MVC point of view, this class acts like a Central "Model" and has Functions of a View
import java.util.ArrayList;
import java.util.Scanner;
import java.io.*;

public class GameHandler{
  Boolean canMove = false;
  String mode;
  MapMenuHandler MMH = new MapMenuHandler();

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
        try{MMH.importLevelindex("Zone/TestZone/Levels.txt");}
      catch(Exception E){rect(200,200,200,200);}
      MMH.displayMapMenu();
    }
  }
  

}
