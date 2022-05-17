#include common_scripts\utility;
#include maps\mp\zombies\_zm;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\zombies\_zm;

init()
{
	level thread onPlayerConnect();
	level thread OverflowFix();
	level thread drawZombiesCounter();
	level.randomguns = false; // Set this variable to true to play with random guns, set it to false to play normal GunGame
	level.notifyText = createServerFontString("hudsmall", 1.9);
	level.notifyText setPoint("CENTER", "CENTER", "CENTER", -150);
}
// Zombies Counter
drawZombiesCounter()
{ // Thanks to CabConModding
	level.zombiesCountDisplay = createServerFontString("hudsmall", 1.9);
	level.zombiesCountDisplay setPoint("CENTER", "CENTER", "CENTER", 200);
	thread updateZombiesCounter();
}
updateZombiesCounter()
{ // Thanks to CabConModding
	level endon("stopUpdatingZombiesCounter");
	while (true)
	{
		zombiesCount = get_current_zombie_count();
		if (zombiesCount >= 0)
		{
			level.zombiesCountDisplay setText("Zombies: ^1" + zombiesCount);
		}
		else
			level.zombiesCountDisplay setText("Zombies: ^2" + zombiesCount);
		waitForZombieCountChanged("stopUpdatingZombiesCounter");
	}
}
recreateZombiesCounter()
{ // Thanks to CabConModding
	level notify("stopUpdatingZombiesCounter");
	thread updateZombiesCounter();
}
waitForZombieCountChanged(endonNotification)
{ // Thanks to CabConModding
	level endon(endonNotification);
	oldZombiesCount = get_current_zombie_count();
	while (true)
	{
		newZombiesCount = get_current_zombie_count();
		if (oldZombiesCount != newZombiesCount)
		{
			return;
		}
		wait 0.05;
	}
}
onPlayerConnect()
{
	for (;;)
	{
		level waittill("connected", player);
		player thread onPlayerSpawned();
	}
}
onPlayerSpawned()
{ // Made by DoktorSAS
	self endon("disconnect");
	level endon("end_game");
	self.info = self createFontString("objective", 1.2);
	self.info setPoint("RIGHT", "RIGHT", 0, 0);
	self.missing = self createFontString("objective", 1.2);
	self.missing setPoint("RIGHT", "RIGHT", 0, -20);
	self.weapons = [];
	self.index = 0;
	self.isO = false;
	self.info.label = &"^6Gun:  ^7";
	self.info setValue(1);
	self.missing.label = &"^6Missing Points:  ^7";
	self.missing setValue(2000);
	map = getDvar("ui_zm_mapstartlocation");
	switch (map)
	{
	case "town":
		self.weapons = strTok("m1911_zm,fiveseven_zm,beretta93r_zm,judge_zm,fivesevendw_zm,mp5k_zm,870mcs_zm,rottweil72_zm,saiga12_zm,tar21_zm,fnfal_zm,m14_zm,galil_zm,barretm82_zm,dsr50_zm,fiveseven_upgraded_zm,beretta93r_upgraded_zm,judge_upgraded_zm,fivesevendw_upgraded_zm,m1911_upgraded_zm,mp5k_upgraded_zm,870mcs_upgraded_zm,rottweil72_upgraded_zm,saiga12_upgraded_zm,tar21_upgraded_zm,fnfal_upgraded_zm,m14_upgraded_zm,galil_upgraded_zm,barretm82_upgraded_zm,dsr50_upgraded_zm", ","); /*This is the List of the weapons, u can change it to add or remove weapons*/
		break;
	case "prison":
		self.weapons = strTok("m1911_zm,fiveseven_zm,beretta93r_zm,judge_zm,fivesevendw_zm,mp5k_zm,pdw57_zm,870mcs_zm,rottweil72_zm,saiga12_zm,tar21_zm,fnfal_zm,m14_zm,galil_zm,barretm82_zm,dsr50_zm,fiveseven_upgraded_zm,beretta93r_upgraded_zm,judge_upgraded_zm,fivesevendw_upgraded_zm,m1911_upgraded_zm,mp5k_upgraded_zm,pdw57_upgraded_zm,870mcs_upgraded_zm,rottweil72_upgraded_zm,saiga12_upgraded_zm,tar21_upgraded_zm,fnfal_upgraded_zm,m14_upgraded_zm,galil_upgraded_zm,barretm82_upgraded_zm,dsr50_upgraded_zm,usrpg_zm,ray_gun_zm,raygun_mark2_zm,usrpg_upgraded_zm,ray_gun_upgraded_zm,raygun_mark2_upgraded_zm", ","); /*This is the List of the weapons, u can change it to add or remove weapons*/
		break;
	case "tomb":
		self.weapons = strTok("c96_zm,fiveseven_zm,beretta93r_zm,fivesevendw_zm,mp40_zm,pdw57_zm,870mcs_zm,fnfal_zm,m14_zm,galil_zm,dsr50_zm,fiveseven_upgraded_zm,beretta93r_upgraded_zm,fivesevendw_upgraded_zm,c96_upgraded_zm,mp40_upgraded_zm,pdw57_upgraded_zm,870mcs_upgraded_zm,fnfal_upgraded_zm,m14_upgraded_zm,galil_upgraded_zm,dsr50_upgraded_zm,ray_gun_zm,raygun_mark2_zm,ray_gun_upgraded_zm,raygun_mark2_upgraded_zm", ","); /*This is the List of the weapons, u can change it to add or remove weapons*/
		break;
	case "farm":
		self.weapons = strTok("m1911_zm,fiveseven_zm,beretta93r_zm,judge_zm,fivesevendw_zm,mp5k_zm,pdw57_zm,870mcs_zm,rottweil72_zm,saiga12_zm,tar21_zm,fnfal_zm,m14_zm,galil_zm,barretm82_zm,dsr50_zm,fiveseven_upgraded_zm,beretta93r_upgraded_zm,judge_upgraded_zm,fivesevendw_upgraded_zm,m1911_upgraded_zm,mp5k_upgraded_zm,pdw57_upgraded_zm,870mcs_upgraded_zm,rottweil72_upgraded_zm,saiga12_upgraded_zm,tar21_upgraded_zm,fnfal_upgraded_zm,m14_upgraded_zm,galil_upgraded_zm,barretm82_upgraded_zm,dsr50_upgraded_zm,usrpg_zm,ray_gun_zm,raygun_mark2_zm,usrpg_upgraded_zm,ray_gun_upgraded_zm,raygun_mark2_upgraded_zm", ","); /*This is the List of the weapons, u can change it to add or remove weapons*/
		break;
	case "processing":
		self.weapons = strTok("m1911_zm,fiveseven_zm,beretta93r_zm,judge_zm,fivesevendw_zm,mp5k_zm,pdw57_zm,870mcs_zm,rottweil72_zm,saiga12_zm,tar21_zm,fnfal_zm,m14_zm,galil_zm,barretm82_zm,dsr50_zm,fiveseven_upgraded_zm,beretta93r_upgraded_zm,judge_upgraded_zm,fivesevendw_upgraded_zm,m1911_upgraded_zm,mp5k_upgraded_zm,pdw57_upgraded_zm,870mcs_upgraded_zm,rottweil72_upgraded_zm,saiga12_upgraded_zm,tar21_upgraded_zm,fnfal_upgraded_zm,m14_upgraded_zm,galil_upgraded_zm,barretm82_upgraded_zm,dsr50_upgraded_zm,usrpg_zm,ray_gun_zm,raygun_mark2_zm,usrpg_upgraded_zm,ray_gun_upgraded_zm,raygun_mark2_upgraded_zm", ","); /*This is the List of the weapons, u can change it to add or remove weapons*/
		break;
	case "rooftop":
		self.weapons = strTok("m1911_zm,fiveseven_zm,beretta93r_zm,judge_zm,fivesevendw_zm,mp5k_zm,pdw57_zm,870mcs_zm,rottweil72_zm,saiga12_zm,tar21_zm,fnfal_zm,m14_zm,galil_zm,barretm82_zm,dsr50_zm,fiveseven_upgraded_zm,beretta93r_upgraded_zm,judge_upgraded_zm,fivesevendw_upgraded_zm,m1911_upgraded_zm,mp5k_upgraded_zm,pdw57_upgraded_zm,870mcs_upgraded_zm,rottweil72_upgraded_zm,saiga12_upgraded_zm,tar21_upgraded_zm,fnfal_upgraded_zm,m14_upgraded_zm,galil_upgraded_zm,barretm82_upgraded_zm,dsr50_upgraded_zm,usrpg_zm,ray_gun_zm,raygun_mark2_zm,usrpg_upgraded_zm,ray_gun_upgraded_zm,raygun_mark2_upgraded_zm", ","); /*This is the List of the weapons, u can change it to add or remove weapons*/
		break;
	case "nuked":
		self.weapons = strTok("m1911_zm,fiveseven_zm,beretta93r_zm,judge_zm,fivesevendw_zm,mp5k_zm,870mcs_zm,rottweil72_zm,saiga12_zm,tar21_zm,fnfal_zm,m14_zm,galil_zm,barretm82_zm,dsr50_zm,fiveseven_upgraded_zm,beretta93r_upgraded_zm,judge_upgraded_zm,fivesevendw_upgraded_zm,m1911_upgraded_zm,mp5k_upgraded_zm,pdw57_upgraded_zm,870mcs_upgraded_zm,rottweil72_upgraded_zm,saiga12_upgraded_zm,tar21_upgraded_zm,fnfal_upgraded_zm,m14_upgraded_zm,galil_upgraded_zm,barretm82_upgraded_zm,dsr50_upgraded_zm,usrpg_zm,ray_gun_zm,raygun_mark2_zm,usrpg_upgraded_zm,ray_gun_upgraded_zm,raygun_mark2_upgraded_zm", ","); /*This is the List of the weapons, u can change it to add or remove weapons*/
		break;
	}
	if (level.randomguns)
	{
		self thread weaponControllRandom();
		self thread pointsMonitorRandom();
		self.randomg = 0;
	}
	else
	{
		self thread pointsMonitor();
		self thread weaponControll();
	}
	self thread weaponControll();
	self waittill("spawned_player");
	self thread AnimatedTextCUSTOMPOS("Welcome to ^5GunGame \n^7Developed by ^5DokotrSAS", 0, 0);
	self takeallweapons();
	self notify("ready");
	for (;;)
	{
		self waittill("spawned_player");
	}
}

AnimatedTextCUSTOMPOS(text, x, y)
{ // Made by DoktorSAS
	level endon("end_game");
	self endon("disconnect");
	textSubStr = getSubStr(text, 0, text.size);
	result = "";
	self.text = self createFontString("hudsmall", 1.9);
	self.text setPoint("CENTER", "CENTER", x, y);
	self.text setText("");
	for (i = 0; i < textSubStr.size; i++)
	{
		color = textSubStr[i] + textSubStr[i + 1];
		if (color == "^1" || color == "^2" || color == "^3" || color == "^4" || color == "^5" || color == "^6" || color == "^7" || color == "^8" || color == "^0" || color == "\n")
		{
			result = result + color;
			i++;
		}
		else
			result = result + textSubStr[i];
		if (i == textSubStr.size)
		{
			self.text setText(text);
		}
		else
		{
			self.text setText(result);
			wait 0.05;
			self.text setText(result + "^7_");
		}
		wait 0.08;
	}
	wait 2;
	self.text setText("");
}
pointsMonitor()
{ // Made by DoktorSAS
	self endon("disconnect");
	level endon("end_game");
	self waittill("ready");
	pointsForNext = 2000; /*Points needed to reaach the next gun*/
	// self.info SetElementText("Weapon: ^5"+self.index+"^1/^7"+self.weapons.size+"\nPoints: ^5"+pointsForNext); /*Print information about weapon and missing points*/
	valueUpate = false;
	ended = true;
	while (ended)
	{
		s = self.score;
		wait 0.05;
		if (self.score > s && self.score != (self.score + 400))
		{
			pointsForNext = pointsForNext - (self.score - s);
			self.info.label = &"^6Gun:  ^7";
			self.info setValue(self.index);
			self.missing.label = &"^6Missing Points:  ^7";
			self.missing setValue(pointsForNext);
			// self.info SetElementText("Weapon: ^5"+self.index+"^1/^7"+self.weapons.size+"\nPoints: ^5"+pointsForNext);
		}
		if (pointsForNext <= 0)
		{
			valueUpate = false;
			pointsForNext = 2000;
			self.index = self.index + 1;
			self.info.label = &"^6Gun:  ^7";
			self.info setValue(self.index);
			self.missing.label = &"^6Missing Points:  ^7";
			self.missing setValue(pointsForNext);
			valueUpate = true;
			// self.info SetElementText("Weapon: ^5"+self.index+"^1/^7"+self.weapons.size+"\nPoints: ^5"+pointsForNext);
		}
		if (self.index == self.weapons.size - 1)
			self thread setNotifyText("^5" + self.name + " ^7is at the last weapon");
		if (self.index == self.weapons.size) /*This controll when player ended the last weapon*/
			ended = false;
	}
	/*You can also add something before this, like animated endgame text or something else*/
	level notify("end_game");
}

setNotifyText(text)
{
	level.notifyText SetElementText(text);
	wait 2;
	textSubStr = getSubStr(text, 0, text.size);
	for (i = 0; i < textSubStr.size; i++)
		t = t + textSubStr[i];
	if (t == text)
		level.notifyText SetElementText("");
}
// List of guns
weaponControll()
{ // Made by DoktorSAS
	self endon("disconnect");
	level endon("end_game");
	self waittill("ready");
	for (;;)
	{
		wait 0.25;
		if (self getCurrentWeapon() != self.weapons[self.index])
		{
			self takeallweapons();
			self giveweapon(self.weapons[self.index]);
			self switchtoweapon(self.weapons[self.index]);
			self iprintln("Test");
		}
		self givemaxammo(self getCurrentWeapon());
	}
}

// Random Guns
weaponControllRandom()
{ // Made by DoktorSAS
	self endon("disconnect");
	level endon("end_game");
	self waittill("ready");
	for (;;)
	{
		wait 0.25;
		if (self getCurrentWeapon() != self.weapons[self.randomg])
		{
			self takeallweapons();
			self giveweapon(self.weapons[self.randomg]);
			self givemaxammo(self getCurrentWeapon());
			self switchtoweapon(self.weapons[self.randomg]);
		}
		self givemaxammo(self getCurrentWeapon());
	}
}
pointsMonitorRandom()
{ // Made by DoktorSAS
	self endon("disconnect");
	level endon("end_game");
	self waittill("ready");
	pointsForNext = 2000; /*Points needed to reaach the next gun*/
	// self.info SetElementText("Weapon: ^5"+self.index+"^1/^7"+self.weapons.size+"\nPoints: ^5"+pointsForNext); /*Print information about weapon and missing points*/
	valueUpate = false;
	ended = true;
	while (ended)
	{
		s = self.score;
		wait 0.05;
		if (self.score > s && self.score != (self.score + 400))
		{
			pointsForNext = pointsForNext - (self.score - s);
			self.info.label = &"^6Gun:  ^7";
			self.info setValue(self.index);
			self.missing.label = &"^6Missing Points:  ^7";
			self.missing setValue(pointsForNext);
			// self.info SetElementText("Weapon: ^5"+self.index+"^1/^7"+self.weapons.size+"\nPoints: ^5"+pointsForNext);
		}
		if (pointsForNext <= 0)
		{
			pointsForNext = 2000;
			self.index = self.index + 1;
			self.randomg = randomintrange(0, self.weapons.size - 1);
			self.info.label = &"^6Gun:  ^7";
			self.info setValue(self.index);
			self.missing.label = &"^6Missing Points:  ^7";
			self.missing setValue(pointsForNext);
			// self.info SetElementText("Weapon: ^5"+self.index+"^1/^7"+self.weapons.size+"\nPoints: ^5"+pointsForNext);
		}
		if (self.index == self.weapons.size - 1)
			self thread setNotifyText("^5" + self.name + " ^7is at the last weapon");
		if (self.index == self.weapons.size) /*This controll when player ended the last weapon*/
			ended = false;
	}
	/*You can also add something before this, like animated endgame text or something else*/
	level notify("end_game");
}
OverflowFix()
{
	level endon("end_game");
	level waittill("connected", player);
	level.stringtable = [];
	level.textelementtable = [];
	textanchor = CreateServerFontString("default", 1);
	textanchor SetElementText("Anchor");
	textanchor.alpha = 0;
	limit = 54;
	while (true)
	{
		if (IsDefined(level.stringoptimization) && level.stringtable.size >= 100 && !IsDefined(textanchor2))
		{
			textanchor2 = CreateServerFontString("default", 1);
			textanchor2 SetElementText("Anchor2");
			textanchor2.alpha = 0;
		}
		if (level.stringtable.size >= limit)
		{
			foreach (player in level.players)
			{
				player.isO = true;
				player.info SetElementText("");
				player.text SetElementText("");
				player.missing SetElementText("");
			}
			if (IsDefined(textanchor2))
			{
				textanchor2 ClearAllTextAfterHudElem();
				textanchor2 DestroyElement();
			}
			textanchor ClearAllTextAfterHudElem();
			level.stringtable = [];
			foreach (textelement in level.textelementtable)
			{
				if (!IsDefined(self.label))
					textelement SetElementText(textelement.text);
				else
					textelement SetElementValueText(textelement.text);
			}

			foreach (player in level.players)
				player.isO = false;
		}
		wait 0.01;
	}
}
SetElementText(text)
{
	self SetText(text);
	if (self.text != text)
		self.text = text;
	if (!IsInArray(level.stringtable, text))
		level.stringtable[level.stringtable.size] = text;
	if (!IsInArray(level.textelementtable, self))
		level.textelementtable[level.textelementtable.size] = self;
}
SetElementValueText(text)
{
	self.label = &"" + text;
	if (self.text != text)
		self.text = text;
	if (!IsInArray(level.stringtable, text))
		level.stringtable[level.stringtable.size] = text;
	if (!IsInArray(level.textelementtable, self))
		level.textelementtable[level.textelementtable.size] = self;
}
DestroyElement()
{
	if (IsInArray(level.textelementtable, self))
		ArrayRemoveValue(level.textelementtable, self);
	if (IsDefined(self.elemtype))
	{
		self.frame Destroy();
		self.bar Destroy();
		self.barframe Destroy();
	}
	self Destroy();
}
drawtext(text, font, fontscale, x, y, color, alpha, glowcolor, glowalpha, sort)
{
	hud = self createfontstring(font, fontscale);
	hud SetElementText(text);
	hud.x = x;
	hud.y = y;
	hud.color = color;
	hud.alpha = alpha;
	hud.glowcolor = glowcolor;
	hud.glowalpha = glowalpha;
	hud.sort = sort;
	hud.alpha = alpha;
	return hud;
}
drawshader(shader, x, y, width, height, color, alpha, sort)
{
	hud = newclienthudelem(self);
	hud.elemtype = "icon";
	hud.color = color;
	hud.alpha = alpha;
	hud.sort = sort;
	hud.children = [];
	hud setparent(level.uiparent);
	hud setshader(shader, width, height);
	hud.x = x;
	hud.y = y;
	return hud;
}
