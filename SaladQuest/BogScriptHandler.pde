static class BSHSingleton
{
  static BogScriptHandler bsh;
  BogScriptHandler getBogScriptHandler()
  {
    if(bsh==null){bsh = new BogScriptHandler();}
    return bsh;
  }
}
static class BogScriptHandler
{
  GameHandler gH;
  MapMenuHandler mMH;
  Level l;
  GameHandler getGameHandler(){return gH;}
  MapMenuHandler getMapMenuHandler(){return mMH;}
  Level getLevel(){return l;}
  void setGameHandler(GameHandler gH){this.gH = gH;}
  void setMapMenuHandler(MapMenuHandler mMH){this.mMH = mMH;}
  void setLevel(Level l){this.l = l;}
  void relayCommand(String target, String command)
  {
    if(target.equals("Game")){gH.processCommand(command);}
    else if(target.equals("Map")){mMH.processCommand(command);}
    else if(target.equals("Level")){l.processCommand(command);}
  }
  void printStatus()
  {
    if(gH!=null){println("gh");}
    if(mMH!=null){println("mmh");}
    if(l!=null){println("l");}
  }
}
interface commandable
{
  void processCommand(String command);
}
