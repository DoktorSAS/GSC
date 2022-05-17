init()
{
    level thread onPlayerConnect();
}
  
onPlayerConnect()
{
    for (;;)
    {
        level waittill("connecting", player);
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned()
{
    level endon("end_game");
    self endon("disconnect");
    self waittill("spawned_player");
    setPlayerMaxHealth( 150 ); // 50 = 1 hit
}


setPlayerMaxHealth( value )
{
    self.maxhealth = value;
    self.health = self.maxhealth;
}
