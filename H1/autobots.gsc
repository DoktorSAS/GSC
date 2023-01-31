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
        if (!player isentityabot())
        {
            player thread kickBotOnJoin();
        }
        else
        {
            player maps\mp\bots\_bots_util::bot_set_difficulty( common_scripts\utility::random( [ "hardened", "veteran" ] ), undefined );
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
    for (;;)
    {
        while (level.players.size < 14 && !level.gameended)
        {
            self spawnBots(1);
            wait 1;
        }
        if (level.players.size >= 17 && contBots() > 0)
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
    spawn_bots(a, "autoassign");
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
