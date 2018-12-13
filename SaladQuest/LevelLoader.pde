public class Level
{
  ArrayList<ArrayList<Entity>> map;
  PImage background;
  Float focusX = 0.0;
  Float focusY = 0.0;
  Float widthX = 0.0; // variable names look 'dumb' to avoid copying preexisting built in "width" and "height"
  Float heightY = 20.0;
  public Level(String file)
  {
    map = new ArrayList<ArrayList<Entity>>();
    background = loadImage("Levels/"+file+"/"+"Background.gif");
  }
  void display()
  {

    if(focusX-8<-7){focusX=-7.0;}//fix this later
    else if(focusX>1536){focusX=1536.0;}//fix this later
    if(focusY<3){focusY=3.0;}//fix this later
    else if(focusY>768.0){focusY=0.0;} //fix this later //Min and max XY locations.
    pushMatrix();
    translate((focusX*64)+512, (256-(heightY*64))+(focusY*64));//this is mostly completely broken
    image(background, 0, 0);
    
    for(int i = 0; i < map.size(); i++)
    {
      ArrayList<Entity> lineMap = map.get(i);
      for(int j = 0; j < lineMap.size(); j++)
      {
        lineMap.get(j).display();
      }
    }
    
    popMatrix();
  }
  void update()
  {
    
  }
}

public abstract class Entity implements Cloneable
{
  float x;
  float y;
  float getX(){return x;}
  float getY(){return y;}
  abstract void display();
}

public class TerreignEntity extends Entity
{
  String art = "";
  Boolean passable;
  ArrayList<String> events = new ArrayList<String>();
  public TerreignEntity(String data)
  {
    String[] datas = data.split(",");
    art = datas[0];
    passable = Boolean.parseBoolean(datas[1]);
    if(!(datas[2].equals("none")))
    {
      datas = datas[2].split("-");
      for(int i = 0; i < datas.length; i++)
      {
        events.add(datas[i]);
      }
    }
  }
  @Override
  void display(){}  
}

public class Unit extends Entity
{
  @Override
  void display(){}
}
