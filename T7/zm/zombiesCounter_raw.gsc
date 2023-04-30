// TODO: Check whats using are not needed for the mapvote purpose
#using scripts\codescripts\struct;

#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\sound_shared;
#using scripts\shared\util_shared;
#using scripts\shared\drown;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\util_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\hud_message_shared;
#using scripts\shared\hud_shared;
#using scripts\shared\ai\zombie_utility;

#insert scripts\shared\shared.gsh;

/*
	Mod: Zombies Counter
	Developed by DoktorSAS
*/

#namespace clientids;

REGISTER_SYSTEM("clientids", &__init__, undefined)

function __init__()
{
	// this is now handled in code ( not lan )
	// see s_nextScriptClientId
	level.clientid = 0;

	callback::on_start_gametype(&init);
	callback::on_connect(&on_player_connect);
}

function init()
{
    zombiesCounterHUD = hud::createServerFontString("objective", 2.4);
	zombiesCounterHUD hud::setPoint("CENTER", "TOP", 200, 45);
	zombiesCounterHUD.hideWhenInMenu = 1;
	zombiesCounterHUD.archived = 0;
	level flag::wait_till("initial_blackscreen_passed");
	level thread counterMonitor(zombiesCounterHUD);
	level thread hudeCounterOnEndgame(zombiesCounterHUD);
}

function on_player_connect()
{
	self.clientid = matchRecordNewPlayer(self);
	if (!isdefined(self.clientid) || self.clientid == -1)
	{
		self.clientid = level.clientid;
		level.clientid++; // Is this safe? What if a server runs for a long time and many people join/leave
	}

	/#
		PrintLn("client: " + self.name + " clientid: " + self.clientid);
	#/
}

function hudeCounterOnEndgame(zombiesCounterHUD)
{
	level waittill("end_game");
	zombiesCounterHUD affectElement("alpha", 4, 0);
	wait 4;
	zombiesCounterHUD destroy();
}

function counterMonitor(zombiesCounterHUD)
{
	level endon("end_game");
	oldZombiesCount = 0;
	while (true)
	{
		zombiesCount = zombie_utility::get_current_zombie_count();
		if (zombiesCount > 0)
		{
			if (oldZombiesCount != zombiesCount)
			{
				oldZombiesCount = zombiesCount;
				zombiesCounterHUD setText("Zombies: ^1" + zombiesCount);
			}
		}
		else
		{
			zombiesCounterHUD affectElement("alpha", 0.2, 0);
			wait 0.2;
			zombiesCounterHUD affectElement("alpha", 0.5, 1);
			zombiesCounterHUD setText("Loading...");

			waitZombiesRespawn();

			zombiesCounterHUD affectElement("alpha", 0.2, 0);
			wait 0.2;
			zombiesCounterHUD setText("Zombies: ^1" + zombie_utility::get_current_zombie_count());
			zombiesCounterHUD affectElement("alpha", 0.5, 1);
		}
		wait 0.5;
	}
}
function waitZombiesRespawn()
{
	while (zombie_utility::get_current_zombie_count() == 0)
	{
		wait 0.05;
	}
}
function affectElement(type, time, value)
{
	if (type == "x" || type == "y")
		self moveOverTime(time);
	else
		self fadeOverTime(time);
	if (type == "x")
		self.x = value;
	if (type == "y")
		self.y = value;
	if (type == "alpha")
		self.alpha = value;
	if (type == "color")
		self.color = value;
}
