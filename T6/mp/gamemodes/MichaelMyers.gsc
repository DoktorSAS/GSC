#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

/*
	Mod: Michael Myers
	Developed by DoktorSAS
*/

init()
{
	level thread onPlayerConnect();
    /*
        Add the following if you are working with custom gametypes and not modifing already existing ones.

        maps\mp\gametypes\_globallogic::init();
        maps\mp\gametypes\_callbacksetup::setupcallbacks();
        maps\mp\gametypes\_globallogic::setupcallbacks();
    */

    level.onstartgametype = ::onstartgametype;
    level.onspawnplayer = ::onspawnplayer;
    level.onspawnplayerunified = ::onspawnplayerunified;
	level.onplayerdamage = ::onplayerdamage;
    level.onplayerkilled = ::onplayerkilled;
    level.givecustomloadout = ::givecustomloadout;
	level.maxkillstreaks = 0; // disable players killstreaks

	registernumlives( 1, 100 );
	// gametype variables
	level.default_mmweapon = "fiveseven_mp";
	level.mm_attacker = undefined;
	level.minplayerstoplay = 4;

    setscoreboardcolumns( "pointstowin", "kills", "deaths", "stabs", "humiliated" );
	thread MichaelMyersStart();
}


MichaelMyersStart()
{
	level waittill("mm_start");
	wait 5;
	// hud info box
	level.mm_infos = SpawnStruct();
	ChooseMichaelMayers();

	
	
}

ChooseMichaelMayers()
{
	level.mm_infos.background = level DrawShader("black", 0, 400, 200, 32, (1, 1, 1), 0.7, 3, "LEFT", "CENTER", 1);
	level.mm_infos.textline = level CreateString("", "objective", 1.2, "CENTER", "CENTER", 0, 212, (1, 1, 1), 1, (0, 0, 0), 0.5, 5);
	level.mm_infos.textline.label = &"Choosing Michael Mayers in ^3";
	for(i = 5; i >= 0; i--)
	{
		level.mm_infos.textline setValue(i);
		wait 0.98;
	}
	level.mm_attacker = level.players[0];
	level.mm_attacker respawnPlayer( game["attackers"] );
	level.mm_infos.textline destroy();
	level.mm_infos.textline = level CreateString("^1" + level.mm_attacker.name, "objective", 1.2, "CENTER", "CENTER", 0, 212, (1, 1, 1), 1, (0, 0, 0), 0.5, 5);

	level.mm_attacker HandleMichaelMyersSafeLocation();
}

HandleMichaelMyersSafeLocation()
{
	level endon("game_ended");
	self endon("disconnect");
	self.safelocation = self.origin;
	self.pers["safelocation"] = self.origin;
	for(;;)
	{
		wait 2.5;
		if(self IsOnGround())
		{
			self.safelocation = self.origin;
			self.pers["safelocation"] = self.origin;
		}
	}
}

onMichaelMyersDisconnect()
{
	level endon("game_ended");
	self waittill("disconnect");
}




main()
{
	replacefunc(maps\mp\gametypes\_globallogic::waitforplayers, ::mm_waitforplayers);
}

mm_waitforplayers()
{
	starttime = gettime();

    while ( getnumconnectedplayers() < level.minplayerstoplay )
    {
        wait 0.05;

        if ( gettime() - starttime > 120000 )
            exitlevel( 0 );
    }
	level notify("mm_start");
}

onPlayerConnect()
{
    level endon("game_ended");
	for (;;)
	{
		level waittill("connected", player);
		player thread onPlayerSpawned();
	}
}

onPlayerSpawned() 
{
    self endon( "disconnect" );
    level endon("game_ended");
    for(;;)
    {
        self waittill( "spawned_player" );
		if (level.teambased && self.pers["team"] == game["attackers"] && (!isDefined(level.mm_attacker) || level.mm_attacker != self))
		{
			respawnPlayer(game["defenders"]);
		}
    }
}

givecustomloadout( takeallweapons, alreadyspawned )
{
    chooserandombody = 0;

    if ( !isdefined( alreadyspawned ) || !alreadyspawned )
        chooserandombody = 1;

    currentweapon = level.default_mmweapon;
    self maps\mp\gametypes\_wager::setupblankrandomplayer( takeallweapons, chooserandombody, currentweapon );
    self disableweaponcycling(); // disable the use of killstreaks if givven
    self giveweapon( currentweapon );
    self switchtoweapon( currentweapon );
	self setweaponammostock( "fiveseven_mp", 0 );
	self setweaponammoclip( "fiveseven_mp", 0 );
    self giveweapon( "knife_mp" );

    if ( !isdefined( alreadyspawned ) || !alreadyspawned )
        self setspawnweapon( currentweapon );

    return currentweapon;
}

onplayerdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime )
{
    if (sMeansOfDeath == "MOD_TRIGGER_HURT" || sMeansOfDeath == "MOD_SUICIDE" || sMeansOfDeath == "MOD_FALLING")
	{
		self setOrigin(self.safelocation);
		return 0;
	}

    return idamage;
}

onplayerkilled( einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    if ( smeansofdeath == "MOD_SUICIDE" || smeansofdeath == "MOD_TRIGGER_HURT" )
    {
        // suicide
        return;
    }

    if ( isdefined( attacker ) && isplayer( attacker ) )
    {
        if ( attacker == self )
        {
            // suicide
            return;
        }

        if ( smeansofdeath == "MOD_MELEE" )
        {
            maps\mp\_scoreevents::processscoreevent( "humiliation_gun", attacker, self, sweapon );
            attacker playlocalsound( game["dialog"]["wm_humiliation"] );
        }
    }
}

onstartgametype()
{
    //level.gungamekillscore = maps\mp\gametypes\_rank::getscoreinfovalue( "kill_gun" );
    //registerscorelimit( level.gunprogression.size * level.gungamekillscore, level.gunprogression.size * level.gungamekillscore );
    setdvar( "scr_xpscale", 0 );
    setclientnamemode( "auto_change" );
    allowed[0] = getDvar("g_gametype");
    maps\mp\gametypes\_gameobjects::main( allowed );
    maps\mp\gametypes\_spawning::create_map_placed_influencers();
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    newspawns = getentarray( "mp_wager_spawn", "classname" );

    if ( newspawns.size > 0 )
    {
        maps\mp\gametypes\_spawnlogic::addspawnpoints( "allies", "mp_wager_spawn" );
        maps\mp\gametypes\_spawnlogic::addspawnpoints( "axis", "mp_wager_spawn" );
    }
    else
    {
        maps\mp\gametypes\_spawnlogic::addspawnpoints( "allies", "mp_dm_spawn" );
        maps\mp\gametypes\_spawnlogic::addspawnpoints( "axis", "mp_dm_spawn" );
    }

    maps\mp\gametypes\_spawning::updateallspawnpoints();
    level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    spawnpoint = maps\mp\gametypes\_spawnlogic::getrandomintermissionpoint();
    setdemointermissionpoint( spawnpoint.origin, spawnpoint.angles );
    level.usestartspawns = 0;
    level.displayroundendtext = 0;
    level.quickmessagetoall = 1;
}

onspawnplayerunified()
{
    maps\mp\gametypes\_spawning::onspawnplayer_unified();
}

onspawnplayer( predictedspawn )
{
    spawnpoints = maps\mp\gametypes\_spawnlogic::getteamspawnpoints( self.pers["team"] );
    spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_dm( spawnpoints );

    if ( predictedspawn )
        self predictspawnpoint( spawnpoint.origin, spawnpoint.angles );
    else
    {
        self spawn( spawnpoint.origin, spawnpoint.angles, getDvar("g_gametype") );
    }
}


// Utils

respawnPlayer(team)
{
	if ( self.sessionstate != "dead" )
    {
        self.switching_teams = 1;
        self.joining_team = team;
        self.leaving_team = self.pers["team"];
		self.lives = level.numlives + 1;
		self.pers["lives"] = self.lives;
        self suicide();
    }

    self.pers["team"] = team;
    self.team = team;
    self.pers["weapon"] = undefined;
    self.pers["spawnweapon"] = undefined;
    self.pers["savedmodel"] = undefined;
    self.pers["teamTime"] = undefined;
    self.sessionteam = self.pers["team"];

    if ( !level.teambased )
        self.ffateam = team;

    /*self maps\mp\gametypes\_globallogic_ui::updateobjectivetext();
    self maps\mp\gametypes\_spectating::setspectatepermissions();
    self notify( "end_respawn" );
	self thread [[level.spawnplayerprediction]] ();*/
	maps\mp\gametypes\_globallogic_spawn::forcespawn(1);
}

/**
 * Checks if the given value is a valid color.
 * A valid color is represented by a string value that is either "0", "1", "2", "3", "4", "5", "6", or "7".
 *
 * @param value - The value to check.
 * @returns true if the value is a valid color, false otherwise.
 */
isValidColor(value)
{
	return value == "0" || value == "1" || value == "2" || value == "3" || value == "4" || value == "5" || value == "6" || value == "7";
}

/**
 * GetColor function returns the RGB values of a specified color.
 *
 * @param {string} color - The color name.
 * @returns {array} - An array containing the RGB values of the specified color.
 */
GetColor(color)
{
	switch (tolower(color))
	{
	case "red":
		return (0.960, 0.180, 0.180);

	case "black":
		return (0, 0, 0);

	case "grey":
		return (0.035, 0.059, 0.063);

	case "purple":
		return (1, 0.282, 1);

	case "pink":
		return (1, 0.623, 0.811);

	case "green":
		return (0, 0.69, 0.15);

	case "blue":
		return (0, 0, 1);

	case "lightblue":
	case "light blue":
		return (0.152, 0.329, 0.929);

	case "lightgreen":
	case "light green":
		return (0.09, 1, 0.09);

	case "orange":
		return (1, 0.662, 0.035);

	case "yellow":
		return (0.968, 0.992, 0.043);

	case "brown":
		return (0.501, 0.250, 0);

	case "cyan":
		return (0, 1, 1);

	case "white":
		return (1, 1, 1);
	}
}
// Drawing
/**
 * Creates a font string and sets its properties.
 *
 * @param {string} input - The text or value to be displayed in the font string.
 * @param {string} font - The font style of the font string.
 * @param {float} fontScale - The scale of the font string.
 * @param {int} align - The alignment of the font string.
 * @param {bool} relative - Determines if the font string's position is relative to its parent.
 * @param {float} x - The x-coordinate of the font string's position.
 * @param {float} y - The y-coordinate of the font string's position.
 * @param {vector} color - The color of the font string.
 * @param {float} alpha - The transparency of the font string.
 * @param {vector} glowColor - The color of the font string's glow effect.
 * @param {float} glowAlpha - The transparency of the font string's glow effect.
 * @param {int} sort - The sorting order of the font string.
 * @param {bool} isValue - Determines if the input is a value instead of text.
 * @returns {fontString} - The created font string.
 */
CreateString(input, font, fontScale, align, relative, x, y, color, alpha, glowColor, glowAlpha, sort, isValue)
{
	if (self != level)
	{
		hud = self createFontString(font, fontScale);
	}
	else
	{
		hud = level createServerFontString(font, fontScale);
	}

	if (!isDefined(isValue))
	{
		hud setText(input);
	}
	else
	{
		hud setValue(int(input));
	}

	hud.x = x;
	hud.y = y;
	hud setparent(level.uiparent);
	hud setPoint(align, relative, x, y);
	hud.color = color;
	hud.alpha = alpha;
	hud.glowColor = glowColor;
	hud.glowAlpha = glowAlpha;
	hud.sort = sort;
	hud.alpha = alpha;
	hud.archived = 0;
	hud.hideWhenInMenu = 0;
	return hud;
}
/**
 * Creates a rectangle HUD element with the specified properties.
 *
 * @param align The alignment of the rectangle.
 * @param relative The relative position of the rectangle.
 * @param x The x-coordinate of the rectangle.
 * @param y The y-coordinate of the rectangle.
 * @param width The width of the rectangle.
 * @param height The height of the rectangle.
 * @param color The color of the rectangle.
 * @param shader The shader of the rectangle.
 * @param sort The sorting order of the rectangle.
 * @param alpha The transparency of the rectangle.
 * @return The created rectangle HUD element.
 */
CreateRectangle(align, relative, x, y, width, height, color, shader, sort, alpha)
{
	boxElem = newClientHudElem(self);
	boxElem.elemType = "icon";
	boxElem.width = width;
	boxElem.height = height;
	boxElem.align = align;
	boxElem.relative = relative;
	boxElem.xOffset = 0;
	boxElem.yOffset = 0;
	boxElem.children = [];
	boxElem.sort = sort;
	boxElem.color = color;
	boxElem.alpha = alpha;
	boxElem setParent(level.uiParent);
	boxElem setShader(shader, width, height);
	boxElem.hidden = 0;
	boxElem setPoint(align, relative, x, y);
	boxElem.hideWhenInMenu = 0;
	boxElem.archived = 0;
	return boxElem;
}
/**
 * Draws a shader on the screen at the specified position with the given dimensions, color, and alpha.
 *
 * @param shader The shader to be drawn.
 * @param x The x-coordinate of the top-left corner of the shader.
 * @param y The y-coordinate of the top-left corner of the shader.
 * @param width The width of the shader.
 * @param height The height of the shader.
 * @param color The color of the shader.
 * @param alpha The alpha value of the shader.
 * @param sort The sorting order of the shader.
 * @param align The alignment of the shader.
 * @param relative Specifies whether the shader's position is relative to the screen or the level.
 * @param isLevel Specifies whether the shader is a level shader or a client shader.
 * @return The created hudelem object representing the drawn shader.
 */
DrawShader(shader, x, y, width, height, color, alpha, sort, align, relative, isLevel)
{
	if (isDefined(isLevel))
		hud = newhudelem();
	else
		hud = newclienthudelem(self);
	hud.elemtype = "icon";
	hud.color = color;
	hud.alpha = alpha;
	hud.sort = sort;
	hud.children = [];
	if (isDefined(align))
		hud.align = align;
	if (isDefined(relative))
		hud.relative = relative;
	hud setparent(level.uiparent);
	hud.x = x;
	hud.y = y;
	hud setshader(shader, width, height);
	hud.hideWhenInMenu = 0;
	hud.archived = 0;
	return hud;
}
// Animations
/**
 * A function that affects the specified element over time.
 * @param {string} type - The type of element to affect ("x", "y", "alpha", "color").
 * @param {number} time - The duration of the effect in milliseconds.
 * @param {number} value - The new value for the specified element.
 */
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