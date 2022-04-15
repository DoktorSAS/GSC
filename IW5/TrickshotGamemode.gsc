#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
/*
    Plutonium IW5 Simple Trickshot Mod
    Developed by DoktorSAS
*/
main()
{	
    SetDvar( "scr_dm_scoreLimit", 250 );
    SetDynamicDvar( "scr_dm_scoreLimit", 250 );
    registerScoreLimitDvar( getDvar("g_gametype"), 250 );

    setDvar("sv_enableBounces", 1);
    setDvar("sv_enableDoubleTaps", 1);

    level.allowPrintDamage = 0;

    level.__vars = [];
    level thread onPlayerConnect();
    level.__vars["prematch_over"] = 0;
    level waittill("prematch_over");
    level thread trickshot_MoabOnEndGame();
    level thread trickshot_SpawnFlags();
    level thread trickshot_changeClassAnytime();
    level.__vars["prematch_over"] = 1;
    level.inGracePeriod = 0;
    level.OriginalCallbackPlayerKilled = level.callbackPlayerKilled;
    level.callbackPlayerKilled = ::CodeCallback_PlayerKilled;
    level.OriginalCallbackPlayerDamage = level.callbackPlayerDamage;
    level.callbackPlayerDamage = ::CodeCallback_PlayerDamage;
    replaceFunc(maps\mp\killstreaks\_airdrop::addCrateType, ::_addCrateType);
}

getTimeLimitFloat()
{
    return getDvarFloat("scr_" + getDvar("g_gametype") + "_timeLimit");
}

trickshot_MoabOnEndGame()
{
    level endon("game_ended");
    time = (getTimeLimitFloat()*60);

    for(;;){
        timePassed = (getTime() - level.startTime)/1000;
        timeRemaining = ( time ) - timePassed;

        if(timeRemaining <= 12){
            maps\mp\killstreaks\_nuke::doNuke( 0 );
            return;
        }

        wait 1;
    }
}

_addCrateType( dropType, crateType, crateWeight, crateFunc )
{
    switch(crateType)
    {
        case "uav":
        case "precision_airstrike":
        case "counter_uav":
        case "deployable_vest":
        case "ims":
            level.crateTypes[dropType][crateType] = crateWeight;
	        level.crateFuncs[dropType][crateType] = crateFunc;
        break;
    }

}


CodeCallback_PlayerKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration)
{
	self endon("disconnect");
    if( eAttacker is_bot() )
    {
        eAttacker.pers["score"] = 0;
    }
    else if(eAttacker.pers["score"] == 150)
    {
        eAttacker thread trickshot_OnLast();
    }
    
	[[level.OriginalCallbackPlayerKilled]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration);
    
}

isSniper( weapon )
{
    return ( 
        isSubstr( weapon, "iw5_dragunov") 
        ||  isSubstr( weapon, "iw5_msr" ) 
        ||  isSubstr( weapon, "iw5_barrett" ) 
        ||  isSubstr( weapon, "iw5_barrett" ) 
        ||  isSubstr( weapon, "iw5_rsass" ) 
        ||  isSubstr( weapon, "iw5_as50" ) 
        ||  isSubstr( weapon, "iw5_l96a1")
        ||  isSubstr( weapon, "iw5_cheytac")
    );
}

CodeCallback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset)
{
	self endon("disconnect");
    
    if(sMeansOfDeath == "MOD_TRIGGER_HURT" || sMeansOfDeath == "MOD_HIT_BY_OBJECT" ||sMeansOfDeath == "MOD_SUICIDE" || sMeansOfDeath == "MOD_FALLING" )
	{
        [[level.OriginalCallbackPlayerDamage]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
        return;
    }

    if(eAttacker is_bot() && self is_bot())
    {
        [[level.OriginalCallbackPlayerDamage]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
        return;
    }
    else if(eAttacker is_bot() && !self is_bot())
    {
        return;
    }
    else if(!eAttacker is_bot() && self is_bot())
    {
        self.health = self.health + iDamage;
    }  

    if( isSniper( sWeapon ) )
    {
        iDamage = 999;  
        if(eAttacker.pers["score"] == 200)
        {
            distance = int(Distance(eAttacker.origin, self.origin)*0.0254);
            if(distance < 10)  
            {
                eAttacker thread SendMessage("Enemy to ^1close", 2);
                return;
            }
            else if(eAttacker isOnGround())
            {
                eAttacker thread SendMessage("Land on ^1ground", 2);
                return;
            }
        }
           
    }
    else 
        iDamage = 0;
    

	[[level.OriginalCallbackPlayerDamage]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
}

is_bot()
{
	assert( isDefined( self ) );
	assert( isPlayer( self ) );

	return ( ( isDefined( self.pers["isBot"] ) && self.pers["isBot"] ) || ( isDefined( self.pers["isBotWarfare"] ) && self.pers["isBotWarfare"] ) || isSubStr( self getguid() + "", "bot" ) );
}


onPlayerConnect()
{
    level endon("game_ended");
	for(;;)
	{
		level waittill( "connected", player );
        if(!player is_bot())
            player thread onPlayerSpawned();
	}
}

trickshot_changeClassAnytime()
{
    level endon("game_ended");
    for(;;)
    {
        level.inGracePeriod = 1;
        foreach(player in level.players) {
            player.hasDoneCombat = 0;
        }
        wait 0.05;
    }
    
}

trickshot_Binds()
{
    self endon("disconnect");
    level endon("game_ended");
    
    self notifyOnPlayerCommand("act1", "+actionslot 1");
    self notifyOnPlayerCommand("act2", "+actionslot 2");
    for(;;)
    {
        cmd = self waittill_any_return("act1", "act2");
        if( isDefined(cmd) )
            continue;
        stance = self getStance();
        if(cmd == "act2")
        {
            if(stance == "crouch")
                self givepredator();
            else if(stance == "prone")
                self dropcanswap();
            else if( self meleeButtonPressed() )
                self dosuicide();
        }
        else
        {
            if(stance == "crouch")
                self setspawn();
            else if(stance == "prone")
                self giveairdrop();
            else if( self meleeButtonPressed() )
                self loadspawn(); 
        }
       
    }
}


onPlayerSpawned()
{
    self endon("disconnect");
    level endon("game_ended");
    self.__vars = [];
    self.__vars["message"] = 0;
    self.__vars["origin"] = (0,0,-999);
    self.__vars["angles"] = self.angles;
    once = 0;
    for(;;)
    {
        self waittill("spawned_player");
        if(self.__vars["origin"] != (0,0,-999))
        {
            self setOrigin(self.__vars["origin"]);
            self setPlayerAngles(self.__vars["angles"]);
        }
        self.hasRadar = 1;
        if(!once)
        {
            self thread trickshot_Binds();
            self iPrintLnBold("Welcome to ^6Trickshot ^7Server");
            once = 1; 
        }
    }
}

	
SendMessage( message, duration )
{
    self endon("disconnect");
    level endon("game_ended");
    self endon("clear_rule");
    if( !self.__vars["message"] )
    {
        self.__vars["message"] = 1;
        self setLowerMessage( "rule", message, duration );
        wait ( duration );
	      self clearLowerMessage( "rule" );
        self.__vars["message"] = 0;
    }   
}

trickshot_OnLast()
{
    self endon("disconnect");
    level endon("game_ended");
    self setBlurForPlayer( 3, 0.4 );
    self freezeControls( 1 );
    self hide();
    self notifyOnPlayerCommand("melee","+melee_zoom");
    self thread SendMessage("You are at ^6Last! ^7\nPress ^6[{+melee_zoom}] ^7to ^5Unfreeze", 5);
    self waittill("melee");
    self notify("clear_rule");
    self clearLowerMessage( "rule" );
    self.__vars["message"] = 0;
    self freezeControls( 0 );
    self setBlurForPlayer(0, 0.4 );
    self show();
}

// Functions
dosuicide()
{
    self suicide();
    self thread SendMessage("Killed by ^2Magic", 1);
}
dropcanswap()
{
    self giveWeapon("iw5_mg36_mp");
    self dropItem("iw5_mg36_mp");
    self thread SendMessage("Canswap ^2Dropped", 1);
}
givepredator()
{
    self maps\mp\killstreaks\_killstreaks::giveKillstreak( "remote_mortar", 0, 0, self, 1 );
}
giveairdrop()
{
    self maps\mp\killstreaks\_killstreaks::giveKillstreak( "airdrop_assault", 0, 0, self, 1 );
}
loadspawn()
{
    if(self.__vars["origin"] != (0,0,-999))
    {
        self setOrigin(self.__vars["origin"]);
        self setPlayerAngles(self.__vars["angles"]);
    }
    self thread SendMessage("Loaded ^5POS", 1);
}
setspawn()
{
    self.__vars["angles"] = self.angles;
    self.__vars["origin"] = self.origin;
    self thread SendMessage("Spawn ^2SET", 1);
}
clearspawn()
{
    self.__vars["origin"] = (0,0,-999);
    self.__vars["angles"] = self.angles;
    self thread SendMessage("Spawn ^1CLEAR", 1);
}

