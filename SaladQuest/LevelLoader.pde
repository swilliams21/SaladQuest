public class Level implements commandable
{
  ArrayList<ArrayList<TerreignEntity>> map;
  ArrayList<TerreignEntity> mapIndex;
  ArrayList<Unit> units;
  Player player;
  PImage background;
  float focusX = 0.0;
  float focusY = 0.0;
  float widthX = 0.0; // variable names look 'dumb' to avoid copying preexisting built in "width" and "height"
  float heightY = 0.0;
  float spawnX = 0.0;
  float spawnY = 0.0;
  float scale = 0.0;
  float gravityX = 0.0;
  float gravityY = 1.0;
  boolean paused = true;
  boolean display = true;
  Unit currentUnit; // mostly unused. It exists for future scripting with BogScript (example)(setcurrentunit>expectednumber deleteunit>expectednumber) It also updates on unit movement pre frame
  public Level(String file, Player  player)
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
    Point p = new Point(x,y);
    this.player = player;
    player.setPoint(p);
    units.add(player);
    }catch(Exception e){print("error");}
    paused = false;
  }
  void display()
  {
    if(display==true)
    {
      Point p = player.getPoint();
      focus(p);
  
      if(focusX<7.5){focusX=7.5;}
      else if(focusX>widthX-7.5){focusX=widthX-7.5;}//fix this later
      if(focusY<3.5){focusY=3.5;}
      else if(focusY>heightY-3.5){focusY=heightY-3.5;} //fix this later //Min and max XY locations.
      background(0);
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
  }
  void focus(Point p)
  {
    focusX = p.getX()/scale;
    focusY = p.getY()/scale;
  }
  void update()
  {
    if(!paused)
    {
      player.playerControl();
      //this is where physics are called
      for(int i = 0; i < units.size(); i++)
      {
        units.get(i).gravity();
        move(units.get(i));
      }
    }
  }
  void move(Unit unit)
  {
    currentUnit = unit;
    if (canMoveX(unit))
    {
      unit.moveX();
    }
    else
    {
      float i = unit.getVelocityX();
      while(i > 1 || i < -1) // this is the simplisitic(easy math) way to improve unit collision but it also less ineficeient. Code can be used to improve this.
      {
        i = i/2;
        unit.setVelocityX(i);
        if(canMoveX(unit))
        {
          unit.moveX();
        }
      }
    }
    if (canMoveY(unit))
    {
      unit.moveY();
      if(unit.getOnGround())
      {
        unit.setVelocityY(2);
        if(canMoveY(unit))
        {
          unit.setOnGround(false);
        }
        unit.setVelocityY(0);
      }
    }
    else
    {
      float i = unit.getVelocityY();
      if(unit.getVelocityY() < 0)
      {
        unit.setOnGround(true);
      }
      while(i > 1 || i < -1) // this is the simplisitic(easy math) way to improve unit collision but it also less ineficeient. Code can be used to improve this.
      {
        i = i/2;
        unit.setVelocityY(i);
        if(canMoveY(unit))
        {
          unit.moveY();
        }
      }
    }
    float x = unit.getCenterX();
    float y = unit.getCenterY();
    TerreignEntity t = getBlock(new Point(x,y));
    t.runEvents();
  }
  boolean canMoveX(Unit unit)
  {
    ArrayList<Point> points;// = unit.collisionPointsRight(scale);
    if(unit.getVelocityX() > 0)
    {
      points = unit.collisionPointsRight(scale);
    }
    else
    {
      points = unit.collisionPointsLeft(scale);
    }
    for(int i = 0; i < points.size(); i++)
    {
      Point p = points.get(i);
      p.addX(unit.getVelocityX());
      TerreignEntity t = getBlock(p);
      if(!t.getPassable())
      {
        return false;
      }
      //print(p.getX());
    }
    return true;
  }
    boolean canMoveY(Unit unit)
  {
        ArrayList<Point> points;// = unit.collisionPointsRight(scale);
    if(unit.getVelocityY() > 0)
    {
      points = unit.collisionPointsUp(scale);
    }
    else
    {
      points = unit.collisionPointsDown(scale);
    }
    for(int i = 0; i < points.size(); i++)
    {
      Point p = points.get(i);
      p.addY(unit.getVelocityY());
      TerreignEntity t = getBlock(p);
      if(!t.getPassable())
      {
        return false;
      }
      //print(p.getX());
    }
    return true;
  }
  TerreignEntity getBlock(Point p)
  {
    int x = Math.round((p.getX() / scale)-.5);
    int y = Math.round((p.getY() / scale)-.5);
    return map.get(x).get(y);
  }
  void key(char a){player.key(a);}
  void noKey(char a){player.noKey(a);}
  void setDisplay(boolean display){this.display = display;}
  @Override
  void processCommand(String command)
  {
    String datas[] = command.split(">");
    if (datas[0].equals("setDisplay")){setDisplay(Boolean.parseBoolean(datas[1]));}
  }
}

public abstract class Entity implements Cloneable
{
  abstract void display();
  abstract void display(int x, int y);
}

public class Point
{
  float x, y;
  public Point(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
  public void addX(float i){x = x + i;}
  public void addY(float i){y = y + i;}
  public float getX(){return x;}
  public float getY(){return y;}
}
