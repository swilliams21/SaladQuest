public class TerreignEntity extends Entity
{
  Boolean passable;
  ArrayList<EventBlock> events = new ArrayList<EventBlock>();
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
        events.add(new EventBlock(datas[i]));
      }
    }
  }
  void runEvents()
  {
    BogScriptHandler bs = new BSHSingleton().getBogScriptHandler();
    for(int i = 0; i < events.size(); i++)
    {
      String target = events.get(i).getTarget();
      String event = events.get(i).getEvent();
      bs.relayCommand(target, event);
      if (!(events.get(i).getRepeatable()))
      {
        i--;
        events.remove(i);
      }
    }
  } 
  boolean getPassable(){return passable;}
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
class EventBlock
{
  String target;
  boolean repeatable;
  String event;
  public EventBlock(String data)
  {
    String[] datas = data.split("<");
    target =  datas[0];
    repeatable = Boolean.parseBoolean(datas[1]);
    event = datas[2];
  }
  String getTarget(){return target;}
  String getEvent(){return event;}
  boolean getRepeatable(){return repeatable;}
}
