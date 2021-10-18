#include maps\mp\_utility;
#include common_scripts\utility;

/*
    Mod: Autoplant & Autodefuse
    Developed by DoktorSAS

    ----------------------------------------------------------------------------------
    This mod was made for S&R servers. Although it works correctly they 
    decided not to use this code but to recreate it in their own way. 

    I don't own Trickshot servers, so I don't care to have this script private. 
    It's very easy to make once you understand where to look.
    ----------------------------------------------------------------------------------

    Prerequisites:
        - Bot Warfare

    The script simply forces players into the team that triggers the bomb and at the correct 
    time defuses the bomb or places it automatically. This script doesn't have much use 
    outside the trickshotting world.
*/

init()
{
    while(!isDefined(getDvar("bots_team")) || getDvar("bots_team") == "")
        wait 0.02;
    setDvar("bots_team", "allies");  // Team of defender
    setDvar("bots_manage_fill", 2); // Number of bots ond efender team
    setDvar("bots_manage_fill_spec", 0);
    setDvar("sd_allowattackersrevive", 0);
    setDvar("scr_sd_timelimit", 2.5);

    level thread onPlayerConnected();   
    level thread doAutoplant();  

    if(getDvarInt("sd_allowattackersrevive") == 0)
        level thread defuseWhenAttakcersDies();

}

thereAttackersAlives()
{
    // Manage if there attackers alive, if not it will return 0
    foreach(player in level.players) 
    {
        if( player isAttacker() && isAlive(player) )
            return 1;
    }
    return 0;
}

defuseWhenAttakcersDies()
{
    level endon("game_ended");
    gameFlagWait( "prematch_done" );
    while(thereAttackersAlives())
        wait 0.05;
    
    level notify("forced_end_game");
    wait 0.05;
    if(level.bombplanted)
        level thread doForceDefuse();
    else
        if(!isOneToWin( getDvar("bots_team") ))
            setDvar("scr_sd_timelimit", 0.01); // Fast Forced end round (Not the best but safe)
}

onPlayerConnected()
{
    level endon("exitLevel_called");
    for(;;)
    {
        level waittill("connected", player);
        player thread onJoinedTeam();
    }
}

onJoinedTeam()
{
    level endon("game_ended");
    self endon("disconnect");
    for(;;)
    {
        self waittill("joined_team");
        self onPlayerSelectTeam();
    }
}

isBot()
{
	return (isDefined(self.pers["isBot"]) && self.pers["isBot"]);
}
isDefender()
{
    return level.bombzones[0] maps\mp\gametypes\_gameobjects::isFriendlyTeam( self.pers["team"] );
}

isAttacker()
{
    return !level.bombzones[0] maps\mp\gametypes\_gameobjects::isFriendlyTeam( self.pers["team"] );
}
onPlayerSelectTeam(){
    //  Move the player in the correct team
    if(!self isBot() &&  self isDefender())
    {
        switch( self.pers["team"] ){
            case "axis": self [[level.allies]](); break;
            case "allies": self [[level.axis]](); break;
	    }
    }
    else if(self isBot() && self isAttacker() )
    {
        switch( self.pers["team"] ){
            case "axis": self [[level.allies]](); break;
            case "allies": self [[level.axis]](); break;
	    }
    }
}

playBombSound()
{  
    // This is just a function to play sound (Already existing inside of S&R Code)
    level endon("defused");
    level endon("game_ended");
    level endon("used_nuke");

    foreach(player in level.players)
        player playLocalSound( "mp_bomb_plant" );

    leaderDialog( "bomb_planted" );
    wait level.bombTimer - .1;
    
    if(!level.gameEnded){
        foreach(player in level.players)
            player playSound("exp_suitcase_bomb_main");
    }
}


doAutoplant()
{
    level endon("forced_end_game");
    level endon("game_ended");
    setDvar("players_team", getOtherTeam( getDvar("bots_team"))); 
    gameFlagWait( "prematch_done" ); // Wait for prematch done

    isPlanted = 1;
    while(isPlanted){
        wait 0.999; // Slow the loop control, its on almost 1 sec to be a bit more accurate in case of issues

        timePassed = (getTime() - level.startTime)/1000;
        timeRemaining = (getDvarFloat("scr_sd_timelimit") * 60) - timePassed;

        if (timeRemaining > 2)
            continue;

        if( isDefined(level.bombzones) )
        {
            if(!isOneToWin(getDvar("players_team")) || !isOneToWin(getDvar("bots_team")))
            {
                if(getDvar("bots_team") != game["attackers"])
                    level thread doDefuse();
            } 
            if(!level.bombplanted && getDvar("players_team") == game["attackers"])
                level thread doPlant();
            isPlanted = 0;
        }
    }
}

doPlant()
{  
    // doPlant is the function who just plant the bomb
    if (!level.bombplanted)
    {
        level thread playBombSound();
        foreach(player in level.players) 
        {
            if(!level.bombzones[1] maps\mp\gametypes\_gameobjects::isFriendlyTeam( player.pers["team"] ))
            {
                level.bombzones[1] maps\mp\gametypes\sd::onuseplantobject(player);  
                return;
            }
    
        }
    }
}  

isOneToWin(team)
{
    return game["roundsWon"][team] == getWatchedDvar( "winlimit" ) - 1;
}

doForceDefuse()
{
    // Defsuse the bomb without wait the bomb timer
    if(!isOneToWin( getDvar("bots_team") ))
    {
        level maps\mp\gametypes\sd::bombDefused();
    }
}
doDefuse()
{
    // Before the bomb explode the bomb will be automaticaly defused
    level endon("game_ended");
    level endon("defused");
    wait level.bombTimer - 3;

    if(!isOneToWin( getDvar("bots_team") ))
    {
        leaderDialog( "bomb_defused" );
        level maps\mp\gametypes\sd::bombDefused();
    }
}
