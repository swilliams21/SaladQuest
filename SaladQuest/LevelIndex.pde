
public class LevelIndex
{
  private int ID, X, Y;
  private boolean locked;
  private boolean selected = false;
  private int[] exitID;
  private char[] exitLetter;
  private String zone;
  
  public int getID(){return ID;}
  public int getX(){return X;}
  public int getY(){return Y;}
  public boolean getLocked(){return locked;}
  public int getExitID(int i){return exitID[i];}
  public char getExitLetter(int i){return exitLetter[i];}
  public int getExitSize(){return exitLetter.length;}
  public String getZone(){return zone;}
  
  public void setLocked(Boolean locked){this.locked = locked;}
  public void setSelected(Boolean selected){this.selected = selected;}
  
  public void display(int x, int y)
  {
    if(locked){fill(255,0,0);}
    else if(selected){fill(255,255,0);}
    else{fill(0,0,255);}
    beginShape();//I'm bad at math just deal with it.
    vertex(X+0+512-x,Y+15+256-y);
    vertex(X+15+512-x,Y+0+256-y);
    vertex(X+0+512-x,Y-15+256-y);
    vertex(X-15+512-x,Y+0+256-y);
    vertex(X+0+512-x,Y+15+256-y);
    endShape();
    System.out.println(ID+","+X+","+Y+","+selected+","+locked);
  }
  
  public LevelIndex(String data)
  {
    try{
    String[] sortedData = data.split(",");
    String[] tempData;
    ID = Integer.parseInt(sortedData[0]);
    X = Integer.parseInt(sortedData[1]);
    Y = Integer.parseInt(sortedData[2]);
    locked = Boolean.parseBoolean(sortedData[3]);
    tempData = sortedData[4].split("-");
    exitID = new int[tempData.length];
    for(int i = 0; i<tempData.length; i++)
    {
      exitID[i]=Integer.parseInt(tempData[i]);
      //System.out.println(exitID[i]);
    }
    //System.out.println(sortedData[5]);
    tempData = sortedData[5].split("-");
    //System.out.println(tempData[0]);
    exitLetter = new char[tempData.length];
    for(int i = 0; i<tempData.length; i++)
    {
      exitLetter[i] = tempData[i].charAt(0);
      //System.out.println(exitLetter[i]);
    }
    zone = sortedData[6];
    }catch(Exception E){exit();}
  }
}
