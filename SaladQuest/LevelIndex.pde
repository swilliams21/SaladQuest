
public class LevelIndex
{
  private int ID, X, Y;
  private boolean locked;
  private int[] exitID;
  private char[] exitLetter;
  
  public int getID(){return ID;}
  public int getX(){return X;}
  public int getY(){return Y;}
  public boolean getLocked(){return locked;}
  public int getexitID(int i){return exitID[i];}
  public char getexitLetter(int i){return exitLetter[i];}
  
  public void setLocked(Boolean locked){this.locked = locked;}
  
  public LevelIndex(String data)
  {
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
    }
    tempData = sortedData[4].split("-");
    exitID = new int[tempData.length];
    for(int i = 0; i<tempData.length; i++)
    {
      exitLetter[i]=(tempData[i]).charAt(0);
    }
  }
}
