#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\_utility;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\gametypes_zm\_hud_util;

/*
	Mod: Zombies+++
	Developed by @DoktorSAS

	Dvars:
	- sv_password : Password used to lock the server once reached a specific round
	- sv_nofog : If set to 0 will disable the fog
	- sv_nodenizen : If set to 0 will disable the denizen
	- sv_lockround : If specified will prevent players from joing after round specifided
	- sv_zombiescounter : If set to 0 will display a zombies counter
	- sv_disableemp : If set to 1 will remove the emp from the Mystery box
	- sv_disabletimebomb : If set to 1 will remove the timebomb from the Mystery box
*/
lockServer(round)
{
	if( round < 0 )
	{
		return;
	}

	while (level.round_number < round)
	{
		wait 0.5;
	}

	setDvar("g_password", GetDvarIntDefault("sv_password", 101001));
	setDvar("password", GetDvarIntDefault("sv_password", 101001));

	level waittill("end_game");
	setDvar("g_password", "");
	setDvar("password", "");
}

init()
{
	
	setupFeatures();
}

setupFeatures()
{	
	setdvar("r_fog", GetDvarIntDefault("sv_nofog", 1));					   
	setdvar("scr_screecher_ignore_player", GetDvarIntDefault("sv_nodenizen", 0)); 

	if( GetDvarIntDefault("sv_lockround", 0) > 0)
	{
		level thread lockServer( );
	}
	
	if( GetDvarIntDefault("sv_zombiescounter", 0) == 1 )
	{
		level thread drawZombiesCounter( );
	}
	if( GetDvarIntDefault("sv_disableemp", 0) == 1 )
	{
		level thread remove_emp();
	}
	if( GetDvarIntDefault("sv_disabletimebomb", 0) == 1 )
	{
		level thread remove_timebomb();
	}
}

drawZombiesCounter( )
{
    zombiesCounter = createServerFontString("objective", 1.4);
	zombiesCounter setPoint("BOTTOM RIGHT", "BOTTOM RIGHT", 0, 0, 0.5);
	zombiesCounter.label = &"Zombies: ^1";
	zombiesCounter.x = zombiesCounter.x - 50;
	zombiesCounter.hideWhenInMenu = 1;
	zombiesCounter.archived = 0;
	if (getDvar("ui_zm_mapstartlocation") == "tomb")
		zombiesCounter.y = zombiesCounter.y - 20;
	zombiesCounter.y = zombiesCounter.y - 50;
	zombiesCounter setValue(0);
	flag_wait("initial_blackscreen_passed");
	oldZombiesCount = 0;
    while(1)
    {
		enemies = get_round_enemy_array().size + level.zombie_total;
		if (enemies > 0)
		{
			if (oldZombiesCount != enemies)
			{
				oldZombiesCount = enemies;
				zombiesCounter setValue(enemies);
			}
		}
		else
		{
			zombiesCounter setValue(0);
			zombiesCounter affectElement("alpha", 0.2, 0);
			wait 0.2;
			zombiesCounter affectElement("alpha", 0.5, 1);

			while (get_current_zombie_count() == 0) // WaiteZombiesRespawn
			{
				wait 0.05;
			}

			zombiesCounter affectElement("alpha", 0.2, 0);
			wait 0.2;
			zombiesCounter setValue(enemies);
			zombiesCounter affectElement("alpha", 0.5, 1);
		}
        wait 0.5;
    }
}

affectElement(type, time, value)
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

remove_emp()
{
	flag_wait("initial_blackscreen_passed");
	weaponKeys = getArrayKeys(level.zombie_weapons);
	foreach (weapon in weaponKeys)
	{
		if (weapon == "emp_grenade_zm")
		{
			level.zombie_weapons[weapon].is_in_box = 0;
		}
	}
}

remove_timebomb()
{
	flag_wait("initial_blackscreen_passed");
	weaponKeys = getArrayKeys(level.zombie_weapons);
	foreach (weapon in weaponKeys)
	{
		if (weapon == "time_bomb_zm")
		{
			level.zombie_weapons[weapon].is_in_box = 0;
		}
	}
}

main()
{
	
}
