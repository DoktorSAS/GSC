#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
    level thread onPlayerConnect();
    showCredits();
}
onPlayerConnect()
{
    for (;;)
    {
        level waittill("connected", player);
        player thread onPlayerSpawned();
    }
}
showCredits()
{
    patreon = self createServerFontString("objective", 0.8);
    patreon setPoint("TOP LEFT", "TOP LEFT", 125, 10);
    patreon setText("Support the servers on ^6Patreon^7:\n^9https://www.patreon.com/DoktorSAS");
    patreon.hidewheninmenu = 1;

    patreon = self createServerFontString("objective", 0.8);
    patreon setPoint("TOP LEFT", "TOP LEFT", 125, 30);
    patreon setText("Vist ^5DoktorSAS ^7website for more info at:\n^9https://doktorsas.xyz/");
    patreon.hidewheninmenu = 1;
}
onPlayerSpawned()
{
    self endon("disconnect");
    level endon("game_ended");
    level endon("end_game");

    once = 0;
    for (;;)
    {
        self waittill("spawned_player");
        if (!once)
        {
            once = 1;
            self iPrintLnBold("Hosted by ^5Sorex");
        }
        self iPrintLn("Developed by @^7DoktorSAS");
    }
}
