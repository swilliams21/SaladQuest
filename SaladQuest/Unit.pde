public class Unit extends Entity implements commandable
{
  float velocityX, velocityY;
  float gravityX, gravityY;
  float centerX, centerY;
  float widthX, heightY;
  float moveSpeed, jumpSpeed, airSpeed;
  boolean onGround = true;
  boolean reversible = true;
  boolean right = true;
  ArrayList<UnitAnimation> animations;
  UnitAnimation currentAnimation;
  public Unit(String fileLocation, float centerX, float centerY)
  {
    try
    {
      this.centerX = centerX;
      this.centerY = centerY;
      velocityX = 0;
      velocityY = 0;
      gravityX = 0;
      gravityY = 1;
      moveSpeed = 5;
      jumpSpeed = 18;
      airSpeed = 1;
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
  
  float getCenterX(){return centerX;}
  float getCenterY(){return centerY;} // redundancy exists for ease of use
  float getVelocityX(){return velocityX;}
  float getVelocityY(){return velocityY;}
  boolean getOnGround(){return onGround;}
  Point getPoint(){return new Point(centerX, centerY);}
  void setVelocityX(float velocityX){this.velocityX=velocityX;}
  void setVelocityY(float velocityY){this.velocityY=velocityY;}
  void setOnGround(boolean ground){onGround = ground;}
  void setPoint(Point p)
  {
   centerX = p.getX();
   centerY = p.getY();
  }
  ArrayList<Point> collisionPointsRight(float scale)
  {
    ArrayList<Point> points = new ArrayList<Point>();
    if(scale<heightY){}//future problem
    else
    {
      float x, y;
      x = centerX + (widthX/2);
      y = centerY + (heightY/2);
      points.add(new Point(x,y));
      y = centerY - (heightY/2);
      points.add(new Point(x,y));
    }
    return points;
  }
  ArrayList<Point> collisionPointsLeft(float scale)
  {
    ArrayList<Point> points = new ArrayList<Point>();
    if(scale<heightY){}//future problem
    else
    {
      float x, y;
      x = centerX - (widthX/2);
      y = centerY + (heightY/2);
      points.add(new Point(x,y));
      y = centerY - (heightY/2);
      points.add(new Point(x,y));
    }
    return points;
  }
  ArrayList<Point> collisionPointsUp(float scale)
  {
    ArrayList<Point> points = new ArrayList<Point>();
    if(scale<widthX){}//future problem
    else
    {
      float x, y;
      y = centerY + (heightY/2);
      x = centerX + (widthX/2);
      points.add(new Point(x,y));
      x = centerX - (widthX/2);
      points.add(new Point(x,y));
    }
    return points;
  }
  ArrayList<Point> collisionPointsDown(float scale)
  {
    ArrayList<Point> points = new ArrayList<Point>();
    if(scale<widthX){}//future problem
    else
    {
      float x, y;
      y = centerY - (heightY/2);
      x = centerX + (widthX/2);
      points.add(new Point(x,y));
      x = centerX - (widthX/2);
      points.add(new Point(x,y));
    }
    return points;
  }
  void moveX()
  {
    centerX = centerX + velocityX;
  }
  void moveY()
  {
    centerY = centerY + velocityY;
  }
  void unitControl(boolean left, boolean right, boolean up)
  {
    if(!(left || right))
    {
      if(onGround){velocityX = 0;}
    }
    else
    {
      if(left)
      {
        if(onGround){velocityX = -moveSpeed;}
        else if(velocityX > -moveSpeed){velocityX = velocityX - airSpeed;}
      }
      if(right)
      {
        if(onGround){velocityX = moveSpeed;}
        else if(velocityX < moveSpeed){velocityX = velocityX + airSpeed;}
      }
    }
    if(up){jump();}
  }
  void gravity()
  {
    if(!onGround)
    {
      velocityY = velocityY - gravityY;
      velocityX = velocityX - gravityX;
    }
  }
  void jump()
  {
    if(onGround)
    {
      onGround = false;
      velocityY = jumpSpeed;
    }
  }
  @Override
  void processCommand(String command)
  {
    String datas[] = command.split(">");
    if (datas[0].equals("reset"))
    {
      if(datas[1].equals("velocity")){velocityX=0;velocityY=0;}
    }
    print("super");
  }
  @Override
  void display(){currentAnimation.display(centerX-widthX/2, -(centerY+heightY/2));}
  @Override
  void display(int x, int y){currentAnimation.display(x, y);}
}

public class Player extends Unit
{
  boolean keyLeft = false;
  boolean keyRight = false;
  boolean keyUp = false; // add more booleans for more controls
  public Player(String fileLocation, float centerX, float centerY)
  {
    super(fileLocation, centerX, centerY);
  }
  void key(char a)
  {
    if(a=='a'){keyLeft=true;}
    else if(a=='d'){keyRight=true;}
    else if(a=='w'){keyUp=true;}
  }
  void noKey(char a)
  {
    if(a=='a'){keyLeft=false;}
    else if(a=='d'){keyRight=false;}
    else if(a=='w'){keyUp=false;}
  }
  void playerControl()
  {
    unitControl(keyLeft, keyRight, keyUp);
  }
  @Override
  void processCommand(String command)
  {
    String datas[] = command.split(">");
    if (datas[0].equals("reset"))
    {
      print("aaa");
      if(datas[1].equals("controls")){keyLeft=false;keyRight=false;keyUp=false;return;}
      else if(datas[1].equals("")){}
      super.processCommand(command);
    }
    else if (false)
    {
      return;
    }
    super.processCommand(command);
  }
}
