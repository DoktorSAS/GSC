#include maps\mp\bots\_bots;
/*
    Mod: Autobots
    Developed by DoktorSAS
*/

init()
{
    level thread onPlayerConnect();
    level thread serverBotFill();
}
onPlayerConnect()
{
	level endon("game_ended");
	for (;;)
	{
		level waittill("connected", player);
		if(!player isentityabot())
		{
			  player thread kickBotOnJoin();
		}
	}
}

isentityabot()
{
	return isSubStr(self getguid(), "bot");
}
serverBotFill()
{
    level endon("game_ended");
	  level waittill("connected", player);
    for(;;)
    {
        while(level.players.size < 14 && !level.gameended)
        {
            self spawnBots(1);
            wait 1;
        }
        if(level.players.size >= 17 && contBots() > 0)
            kickbot();

        wait 0.05;
    }
}

contBots()
{
    bots = 0;
    foreach (player in level.players) 
    {
        if (player isentityabot()) 
        {
            bots++;
        }
    }
    return bots;
}

spawnBots(a)
{
    _id_88D2(a, "autoassign"); // spawnbots(n, team); 
}

kickbot()
{
    level endon("game_ended");
    foreach (player in level.players) 
    {
        if (player isentityabot()) 
        {
            player _id_1603(); //  bot_drop();
            break;
        }
    }
}

kickBotOnJoin()
{
    level endon("game_ended");
    foreach (player in level.players) 
    {
        if (player isentityabot()) 
        {
	          player _id_1603(); //  bot_drop();
            break;
        }
    }
}
