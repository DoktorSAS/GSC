
#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\_utility;
#include maps\mp\gametypes\_hud;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_spectating;

CreateFlag(origin, end)
{
	/*object = spawnstruct();
	object.type = "flag";
	object.triggertype = "triggertype";*/
	
	trigger = spawn("trigger_radius_use", origin + (0, 0, 70), 0, 72, 64);
	trigger sethintstring("Press ^3[{+activate}] ^7to teleport");
	trigger setcursorhint("HINT_NOICON");
	trigger usetriggerrequirelookat();
	trigger triggerignoreteam();
	trigger thread DestroyOnEndGame();

	//object.entnum = trigger getentitynumber();

	teleport = spawn("script_model", origin);
	teleport setmodel("mp_flag_allies_1");
	teleport thread TeleportPlayer(trigger, end);
	teleport thread DestroyOnEndGame();

	if(!isDefined(level.tp_flags)) level.tp_flags = 0;
	else level.tp_flags++;

	attach2DIcon(teleport, level.tp_flags, "waypoint_recon_artillery_strike");
}

attach2DIcon(object, objectiveid, icon) 
{
	/*
		object		: It rappresent the model and not the trigger
		objectiveid	: It is an index and must be numeric
		icon		: It is the shader name
	*/
	objective_add( objectiveid, "active", object.origin );
	objective_icon( objectiveid, icon);
	if(isDefined(object))
	{
		objective_onentity( objectiveid, object );
	}
}

TeleportPlayer(trigger, end)
{
	level endon("game_ended");
	while (isDefined(self))
	{
		trigger waittill("trigger", player);
		if (player IsPlayerOnLast())
		{
			player setOrigin(end);
		}
	}
}

DestroyOnEndGame()
{
	level waittill("game_ended");
	self delete ();
}