public class GameHandler{
  Boolean canMove = false;
  String mode;
  

  public void displayMainMenu()
  {
    //artist and UI people draw here
    background(100);//this can be replaced with an image file later
    stroke(0);//black
    fill(150);//shade of gray
    rect(50,50,200,50);
    background(255);
  }
  public void displayMapMenu()
  {
    //artist and UI people draw here//
    background(255);
  }
  
  Boolean canMove(){return canMove;}
  void canMove(boolean b){canMove=b;}
  String mode(){return mode;}
  void mode(String m){
    mode=m;
    if(m.equals("Main Menu"))
    {
      displayMainMenu();
    }
    else if(m.equals("Map Menu"))
    {
      displayMapMenu();
    }
  }
}
