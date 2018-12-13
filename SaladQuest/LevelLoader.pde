public class Level
{
  ArrayList<ArrayList<Entity>> map;
  PImage background;
  Float focusX = 0.0;
  Float focusY = 0.0;
  Float widthX = 0.0; // variable names look 'dumb' to avoid copying preexisting built in "width" and "height"
  Float heightY = 0.0;
  public Level(String file)
  {
    map = new ArrayList<ArrayList<Entity>>();
    background = loadImage("Levels/"+file+"/"+"Background.gif");
  }
  void display()
  {
     /*menuMapX = currentLevel.getX();
     menuMapY = currentLevel.getY();
    if(menuMapX<512){menuMapX=512;}
    else if(menuMapX>1536){menuMapX=1536;}
    if(menuMapY<256){menuMapY=256;}
    else if(menuMapY>768){menuMapY=768;} // Min and max XY locations.*/
    pushMatrix();
    translate((focusX*64)+512, 256-(heightY*64)-(focusY*64));
    image(background, 0, 0);//update later to adjuster loaded from file
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
