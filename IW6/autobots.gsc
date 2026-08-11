#include maps\mp\bots\_bots;
#include maps\mp\_utility;
/*
    Mod: Autobots
    Developed by DoktorSAS
*/

init()
{
    level thread onPlayerConnect();

    if(!level.teambased)
    {
        setdvarifuninitialized("force_bots_team", game["defenders"]);
        setdvarifuninitialized("min_bots", 0);
        setdvarifuninitialized("max_bots", 6);
    }
    else
    {
        setdvarifuninitialized("min_bots", 2);
        setdvarifuninitialized("max_bots", 2);
    }

    if(level.teambased && game["roundsPlayed"] == 0) // This is to prevent the execution of the init on SD and SR
    {
        level thread botsAutoFill();
    }
    else if(!level.teambased)
    {
        level thread botsAutoFill();
    }
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
	return isSubStr(self getguid(), "bot") || isai( self ) || issubstr( self.name, "tcBot" );
}

botsAutoFill()
{
    level endon("game_ended");
    level waittill("connected", player);

    max_bots = getDvarInt("max_bots");
    min_bots = getDvarInt("min_bots");
    force_bots_team = getDvarInt("force_bots_team");
    bots_team = "autoassign";
    if(level.teambased && force_bots_team != undefined)
        bots_team = force_bots_team;

    party_maxplayers = getDvarInt("party_maxplayers");
    for(;;)
    {
        numBots = contBots();
        setDvar("num_bots", numBots);
        totPlayers = level.players.size;
        if(level.teambased)
        {
            if(totPlayers >= int(party_maxplayers / 2 - 1) && numBots > 0 && numBots > min_bots)
            {
                kickbot();
            }
            
            while(totPlayers < int(party_maxplayers / 2 - 1) && !level.gameended && numBots < max_bots)
            {
                spawn_bots(1, bots_team); // _id_778F(n, team); 
                numBots++;
                wait 1;
            }
        }
        else
        {
            if(totPlayers >= party_maxplayers - 1 && numBots > 0 && numBots > min_bots)
            {
                kickbot();
            }
            
            while(totPlayers < party_maxplayers - 2 && !level.gameended && numBots < max_bots)
            {
                spawn_bots(1, bots_team); // _id_778F(n, team); 
                numBots++;
                wait 1;
            }
        }
        
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

spawnBotswrapper(a)
{
    spawn_bots(a, "autoassign"); // _id_778F(n, team); 
}

kickbot()
{
    level endon("game_ended");
    foreach (player in level.players) 
    {
        if (player isentityabot()) 
        {
            player bot_drop();
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
	        player bot_drop();
            break;
        }
    }
}
