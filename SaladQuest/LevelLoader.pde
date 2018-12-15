public class Level
{
  ArrayList<ArrayList<TerreignEntity>> map;
  ArrayList<TerreignEntity> mapIndex;
  PImage background;
  Float focusX = 0.0;
  Float focusY = 0.0;
  Float widthX = 0.0; // variable names look 'dumb' to avoid copying preexisting built in "width" and "height"
  Float heightY = 0.0;
  float scale = 64.0;
  public Level(String file)
  {
    map = new ArrayList<ArrayList<TerreignEntity>>();
    mapIndex = new ArrayList<TerreignEntity>();
    background = loadImage("Levels/"+file+"/"+"Background.gif");
    BufferedReader scanMapIndex = createReader("Levels/"+file+"/"+"TerriegnEntities.txt");
    BufferedReader scanMap = createReader("Levels/"+file+"/"+"Map.txt");
    BufferedReader scanLHS = createReader("Levels/"+file+"/"+"LengthHeightScale.txt");
    BufferedReader scanSpawn = createReader("Levels/"+file+"/"+"SpawnLocation.txt");
    try
    {
      String data = scanMapIndex.readLine();
      while(data != null)
      {
        /*print("data: ");
        println(data);*/
        BufferedReader temp = createReader(data);
        data = temp.readLine();
        mapIndex.add(new TerreignEntity(data));
        data = scanMapIndex.readLine();
      }
      
      widthX = (float)Integer.parseInt(scanLHS.readLine());
      heightY = (float)Integer.parseInt(scanLHS.readLine());
      scale = (float)Integer.parseInt(scanLHS.readLine());
      
      data = scanMap.readLine();
      
      for (int i = 0; i < widthX; i++)
      {
        print("data: ");
        println(data);
        ArrayList<TerreignEntity> column = new ArrayList<TerreignEntity>();
        String[] datas = data.split(",");
        for (int j = 0; j < heightY; j++)
        {
          int k = Integer.parseInt(datas[j]);
          column.add(mapIndex.get(k));
          println(k);
        }
        map.add(column);
        data = scanMap.readLine();
      }
    }catch(Exception e){print("error");}
    
  }
  void display()
  {

    if(focusX<7.5){focusX=7.5;}
    else if(focusX>1536){focusX=1536.0;}//fix this later
    if(focusY<3.5){focusY=3.5;}
    else if(focusY>768.0){focusY=0.0;} //fix this later //Min and max XY locations.
    
    pushMatrix();
    translate(width/2, height/2);
    translate(0, -heightY*scale);
    translate(-(focusX*scale), (focusY*scale));//this is mostly completely broken
    image(background, 0, 0);
    popMatrix();
    pushMatrix();
    translate(width/2, height/2-scale);
    translate(-(focusX*64), (focusY*scale));
    for(int i = 0; i < map.size(); i++)
    {
      ArrayList<TerreignEntity> lineMap = map.get(i);
      pushMatrix();
      for(int j = 0; j < lineMap.size(); j++)
      {
        lineMap.get(j).display();
        translate(0,-scale);
      }
      popMatrix();
      translate(scale,0);
    }
    popMatrix();
  }
  void update()
  {
    
  }
}

public abstract class Entity implements Cloneable
{
  abstract void display();
  abstract void display(int x, int y);
}

public class TerreignEntity extends Entity
{
  Boolean passable;
  ArrayList<String> events = new ArrayList<String>();
  PImage art = null;
  public TerreignEntity(String data)
  {
    String[] datas = data.split(",");
    if (!(datas[0].equals("none")))
    {
      art = loadImage(datas[0]);
    }
    
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
  void display()
  {
    if(art!=null)
    {
      image(art,0,0);
    }
  }
  @Override
  void display(int x, int y)
  {
    if(art!=null)
    {
      image(art,x,y);
    }
  }  
}

public class Unit extends Entity
{
  @Override
  void display(){}
  @Override
  void display(int x, int y){}
}
