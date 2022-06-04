#include common_scripts\utility;
#include maps\_utility;
#include maps\_hud_util;

/*
	Mod: Black ops Plutonium zombies counter
	Developed by Cabcon and optimized by DoktorSAS
*/

init()
{
	init_ZombiesCounter();
}

init_ZombiesCounter()
{
	zombiesCounter = createServerFontString("hudsmall", 1.2);
	zombiesCounter setPoint("BOTTOM RIGHT", "BOTTOM RIGHT", 0, 0, 0.5);
	zombiesCounter.x = zombiesCounter.x - 125;
	zombiesCounter.hideWhenInMenu = 1;
	zombiesCounter.archived = 0;
	zombiesCounter.y = zombiesCounter.y - 5;
	zombiesCounter setText("Loading...");
	level thread ZC_Monitor(zombiesCounter);
	level thread ZC_HideOnEndGame(zombiesCounter);
}

ZC_HideOnEndGame(zombiesCounter)
{
	level waittill("end_game");
	zombiesCounter affectElement("alpha", 4, 0);
	wait 4;
	zombiesCounter destroy();
}

get_current_zombie_count()
{
    zombies = GetAIArray( "axis");
    return zombies.size;
}


ZC_Monitor(zombiesCounter)
{
	level endon("end_game");
	oldZombiesCount = 0;
	while (true)
	{
		zombiesCount = get_current_zombie_count();
		if (zombiesCount > 0)
		{
			if (oldZombiesCount != zombiesCount)
			{
				oldZombiesCount = zombiesCount;
				zombiesCounter setText("Zombies: ^1" + zombiesCount);
			}
		}
		else
		{
			zombiesCounter affectElement("alpha", 0.2, 0);
			wait 0.2;
			zombiesCounter affectElement("alpha", 0.5, 1);
			zombiesCounter setText("Loading...");

			ZC_WaitZombiesRespawn();

			zombiesCounter affectElement("alpha", 0.2, 0);
			wait 0.2;
			zombiesCounter setText("Zombies: ^1" +  (get_current_zombie_count()) );
			zombiesCounter affectElement("alpha", 0.5, 1);
		}
		wait 0.5;
	}
}
ZC_WaitZombiesRespawn()
{
	while (get_current_zombie_count() == 0)
	{
		wait 0.05;
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
