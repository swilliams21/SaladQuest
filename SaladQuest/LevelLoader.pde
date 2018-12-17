public class Level
{
  ArrayList<ArrayList<TerreignEntity>> map;
  ArrayList<TerreignEntity> mapIndex;
  ArrayList<Unit> units;
  PImage background;
  float focusX = 0.0;
  float focusY = 0.0;
  float widthX = 0.0; // variable names look 'dumb' to avoid copying preexisting built in "width" and "height"
  float heightY = 0.0;
  float spawnX = 0.0;
  float spawnY = 0.0;
  float scale = 0.0;
  public Level(String file)
  {
    map = new ArrayList<ArrayList<TerreignEntity>>();
    mapIndex = new ArrayList<TerreignEntity>();
    units = new ArrayList<Unit>();
    background = loadImage("Levels/"+file+"/"+"Background.png");
    BufferedReader scanMapIndex = createReader("Levels/"+file+"/"+"TerriegnEntities.txt");
    BufferedReader scanMap = createReader("Levels/"+file+"/"+"Map.txt");
    BufferedReader scanLHS = createReader("Levels/"+file+"/"+"LengthHeightScale.txt");
    BufferedReader scanSpawn = createReader("Levels/"+file+"/"+"SpawnLocation.txt");
    // add code for units and events scripts
    try
    {
      String data = scanMapIndex.readLine();
      while(data != null)
      {
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
        }
        map.add(column);
        data = scanMap.readLine();
      }
    float x = scale*((float)Integer.parseInt(scanSpawn.readLine())+.501);
    float y = scale*((float)Integer.parseInt(scanSpawn.readLine())+.501);
    Unit player = new Unit("CommonEntity/Unit/Player/Player.txt", x, y);
    units.add(player);
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
    pushMatrix();
    translate(width/2, height/2);
    translate(-focusX*scale, focusY*scale);
    for(int i = 0; i < units.size(); i++)
    {
      units.get(i).display();
    }
    popMatrix();
  }
  void update()
  {
    //this is where physics are called
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
  float centerX, centerY;
  float widthX, heightY;
  ArrayList<UnitAnimation> animations;
  UnitAnimation currentAnimation;
  public Unit(String fileLocation, float centerX, float centerY)
  {
    try
    {
      this.centerX = centerX;
      this.centerY = centerY;
      String data, name, file;
      animations = new ArrayList<UnitAnimation>();
      BufferedReader scanUnitIndex = createReader(fileLocation);
      data = scanUnitIndex.readLine();
      BufferedReader scanAnimation = createReader(data);
      name = scanAnimation.readLine();
      file = scanAnimation.readLine();
      while(file!=null)
      {
        animations.add(new UnitAnimation(name, file));
        name = scanAnimation.readLine();
        file = scanAnimation.readLine();
      }
      currentAnimation = animations.get(0);
      data = scanUnitIndex.readLine();
      BufferedReader scanWidthHeight = createReader(data);
      widthX = (float)Integer.parseInt(scanWidthHeight.readLine());
      heightY = (float)Integer.parseInt(scanWidthHeight.readLine());
      
    }catch(Exception e){print("file read error");}
  }
  @Override
  void display(){currentAnimation.display(centerX-widthX/2, -(centerY+heightY/2));}
  @Override
  void display(int x, int y){print("this is coded wrong");}
}

public class UnitAnimation
{
  String name;
  int counter;
  int base = 0;
  ArrayList<PImage> frame = new ArrayList<PImage>();
  public UnitAnimation(String name, String fileLocation)
  {
    String frameLocation, frameIndex, data;
    counter = 0;
    try{
      this.name = name;
      ArrayList<PImage> tempList = new ArrayList<PImage>();
      BufferedReader scan = createReader(fileLocation);
      frameLocation = scan.readLine();
      frameIndex = scan.readLine();
      BufferedReader scanLocation = createReader(frameLocation);
      BufferedReader scanIndex = createReader(frameIndex);
      data = scanLocation.readLine();
      while(data!=null)
      {
        PImage picture = loadImage(data);
        tempList.add(picture);
        data = scanLocation.readLine();
      }
      data = scanIndex.readLine();
      while(data!=null)
      {
        int i = Integer.parseInt(data);
        frame.add(tempList.get(i));
        data = scanIndex.readLine();
      }
    }catch(Exception e){print("animation read error");}
  }
  public String getName()
  {
    return name;
  }
  public void resetCounter()
  {
    counter = 0;
  }
  public void display(float x, float y)
  {
    PImage picture = frame.get(counter);
    image(picture, x, y);
    counter++;
    if (counter >= frame.size())
    {
      counter = base;
    }
  }
}
public class point
{
  float x, y;
  public point(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
  public float getX(){return x;}
  public float getY(){return y;}
}
