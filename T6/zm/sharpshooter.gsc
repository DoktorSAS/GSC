#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\zombies\_zm;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;

/*
    Mod: Sharpshooter
    Developed by @DoktorSAS

    Requirements:
    The overflowFix.gsc is needed to prevent crash from string overflow. The file is
    provided in this github.
*/
init()
{
    if(getDvar("sv_gametype") != "sh")
        return;
    
    precacheshader("menu_zm_gamertag");
    level thread onPlayerConnect();
    /*
        if level.ss_rotation is set to 0 the gun rotation will be infinite.
        if level.ss_rotation is set to any number it will rotate that amount of number.
    */
    level.ss_rotation = 0;

    /*
        level.ss_time rappresent the time to rotete to the next weapon
    */
    level.ss_time = 45;
    map = getDvar("ui_zm_mapstartlocation");
    switch (map)
    {
    case "transit":
        insertWeapon("m1911_zm");
        insertWeapon("fiveseven_zm");
        insertWeapon("beretta93r_zm");
        insertWeapon("judge_zm");
        insertWeapon("fivesevendw_zm");
        insertWeapon("mp5k_zm");
        insertWeapon("870mcs_zm");
        insertWeapon("rottweil72_zm");
        insertWeapon("saiga12_zm");
        insertWeapon("tar21_zm");
        insertWeapon("fnfal_zm");
        insertWeapon("m14_zm");
        insertWeapon("galil_zm");
        insertWeapon("barretm82_zm");
        insertWeapon("dsr50_zm");
        insertWeapon("fiveseven_upgraded_zm");
        insertWeapon("beretta93r_upgraded_zm");
        insertWeapon("judge_upgraded_zm");
        insertWeapon("fivesevendw_upgraded_zm");
        insertWeapon("m1911_upgraded_zm");
        insertWeapon("mp5k_upgraded_zm");
        insertWeapon("870mcs_upgraded_zm");
        insertWeapon("rottweil72_upgraded_zm");
        insertWeapon("saiga12_upgraded_zm");
        insertWeapon("tar21_upgraded_zm");
        insertWeapon("fnfal_upgraded_zm");
        insertWeapon("m14_upgraded_zm");
        insertWeapon("galil_upgraded_zm");
        insertWeapon("barretm82_upgraded_zm");
        insertWeapon("dsr50_upgraded_zm");
        insertWeapon("usrpg_zm");
        insertWeapon("ray_gun_zm");
        insertWeapon("raygun_mark2_zm");
        insertWeapon("usrpg_upgraded_zm");
        insertWeapon("ray_gun_upgraded_zm");
        insertWeapon("raygun_mark2_upgraded_zm");
        break;
    case "town":
        insertWeapon("m1911_zm");
        insertWeapon("fiveseven_zm");
        insertWeapon("beretta93r_zm");
        insertWeapon("judge_zm");
        insertWeapon("fivesevendw_zm");
        insertWeapon("mp5k_zm");
        insertWeapon("870mcs_zm");
        insertWeapon("rottweil72_zm");
        insertWeapon("saiga12_zm");
        insertWeapon("tar21_zm");
        insertWeapon("fnfal_zm");
        insertWeapon("m14_zm");
        insertWeapon("galil_zm");
        insertWeapon("barretm82_zm");
        insertWeapon("dsr50_zm");
        insertWeapon("fiveseven_upgraded_zm");
        insertWeapon("beretta93r_upgraded_zm");
        insertWeapon("judge_upgraded_zm");
        insertWeapon("fivesevendw_upgraded_zm");
        insertWeapon("m1911_upgraded_zm");
        insertWeapon("mp5k_upgraded_zm");
        insertWeapon("870mcs_upgraded_zm");
        insertWeapon("rottweil72_upgraded_zm");
        insertWeapon("saiga12_upgraded_zm");
        insertWeapon("tar21_upgraded_zm");
        insertWeapon("fnfal_upgraded_zm");
        insertWeapon("m14_upgraded_zm");
        insertWeapon("galil_upgraded_zm");
        insertWeapon("barretm82_upgraded_zm");
        insertWeapon("dsr50_upgraded_zm");
        insertWeapon("usrpg_zm");
        insertWeapon("ray_gun_zm");
        insertWeapon("raygun_mark2_zm");
        insertWeapon("usrpg_upgraded_zm");
        insertWeapon("ray_gun_upgraded_zm");
        insertWeapon("raygun_mark2_upgraded_zm");
        break;
    case "prison":
        insertWeapon("m1911_zm");
        insertWeapon("fiveseven_zm");
        insertWeapon("beretta93r_zm");
        insertWeapon("judge_zm");
        insertWeapon("fivesevendw_zm");
        insertWeapon("mp5k_zm");
        insertWeapon("pdw57_zm");
        insertWeapon("870mcs_zm");
        insertWeapon("rottweil72_zm");
        insertWeapon("saiga12_zm");
        insertWeapon("tar21_zm");
        insertWeapon("fnfal_zm");
        insertWeapon("m14_zm");
        insertWeapon("galil_zm");
        insertWeapon("barretm82_zm");
        insertWeapon("dsr50_zm");
        insertWeapon("fiveseven_upgraded_zm");
        insertWeapon("beretta93r_upgraded_zm");
        insertWeapon("judge_upgraded_zm");
        insertWeapon("fivesevendw_upgraded_zm");
        insertWeapon("m1911_upgraded_zm");
        insertWeapon("mp5k_upgraded_zm");
        insertWeapon("pdw57_upgraded_zm");
        insertWeapon("870mcs_upgraded_zm");
        insertWeapon("rottweil72_upgraded_zm");
        insertWeapon("saiga12_upgraded_zm");
        insertWeapon("tar21_upgraded_zm");
        insertWeapon("fnfal_upgraded_zm");
        insertWeapon("m14_upgraded_zm");
        insertWeapon("galil_upgraded_zm");
        insertWeapon("barretm82_upgraded_zm");
        insertWeapon("dsr50_upgraded_zm");
        insertWeapon("usrpg_zm");
        insertWeapon("ray_gun_zm");
        insertWeapon("raygun_mark2_zm");
        insertWeapon("usrpg_upgraded_zm");
        insertWeapon("ray_gun_upgraded_zm");
        insertWeapon("raygun_mark2_upgraded_zm");
        break;
    case "tomb":
        insertWeapon("c96_zm");
        insertWeapon("fiveseven_zm");
        insertWeapon("beretta93r_zm");
        insertWeapon("fivesevendw_zm");
        insertWeapon("mp40_zm");
        insertWeapon("pdw57_zm");
        insertWeapon("870mcs_zm");
        insertWeapon("fnfal_zm");
        insertWeapon("m14_zm");
        insertWeapon("galil_zm");
        insertWeapon("dsr50_zm");
        insertWeapon("fiveseven_upgraded_zm");
        insertWeapon("beretta93r_upgraded_zm");
        insertWeapon("fivesevendw_upgraded_zm");
        insertWeapon("c96_upgraded_zm");
        insertWeapon("mp40_upgraded_zm");
        insertWeapon("pdw57_upgraded_zm");
        insertWeapon("870mcs_upgraded_zm");
        insertWeapon("fnfal_upgraded_zm");
        insertWeapon("m14_upgraded_zm");
        insertWeapon("galil_upgraded_zm");
        insertWeapon("dsr50_upgraded_zm");
        insertWeapon("ray_gun_zm");
        insertWeapon("raygun_mark2_zm");
        insertWeapon("ray_gun_upgraded_zm");
        insertWeapon("raygun_mark2_upgraded_zm");
        // self.weapons = strTok("c96_zm,fiveseven_zm,beretta93r_zm,fivesevendw_zm,mp40_zm,pdw57_zm,870mcs_zm,fnfal_zm,m14_zm,galil_zm,dsr50_zm,fiveseven_upgraded_zm,beretta93r_upgraded_zm,fivesevendw_upgraded_zm,c96_upgraded_zm,mp40_upgraded_zm,pdw57_upgraded_zm,870mcs_upgraded_zm,fnfal_upgraded_zm,m14_upgraded_zm,galil_upgraded_zm,dsr50_upgraded_zm,ray_gun_zm,raygun_mark2_zm,ray_gun_upgraded_zm,raygun_mark2_upgraded_zm", ","); /*This is the List of the weapons, u can change it to add or remove weapons*/
        break;
    case "farm":
        insertWeapon("m1911_zm");
        insertWeapon("fiveseven_zm");
        insertWeapon("beretta93r_zm");
        insertWeapon("judge_zm");
        insertWeapon("fivesevendw_zm");
        insertWeapon("mp5k_zm");
        insertWeapon("pdw57_zm");
        insertWeapon("870mcs_zm");
        insertWeapon("rottweil72_zm");
        insertWeapon("saiga12_zm");
        insertWeapon("tar21_zm");
        insertWeapon("fnfal_zm");
        insertWeapon("m14_zm");
        insertWeapon("galil_zm");
        insertWeapon("barretm82_zm");
        insertWeapon("dsr50_zm");
        insertWeapon("fiveseven_upgraded_zm");
        insertWeapon("beretta93r_upgraded_zm");
        insertWeapon("judge_upgraded_zm");
        insertWeapon("fivesevendw_upgraded_zm");
        insertWeapon("m1911_upgraded_zm");
        insertWeapon("mp5k_upgraded_zm");
        insertWeapon("pdw57_upgraded_zm");
        insertWeapon("870mcs_upgraded_zm");
        insertWeapon("rottweil72_upgraded_zm");
        insertWeapon("saiga12_upgraded_zm");
        insertWeapon("tar21_upgraded_zm");
        insertWeapon("fnfal_upgraded_zm");
        insertWeapon("m14_upgraded_zm");
        insertWeapon("galil_upgraded_zm");
        insertWeapon("barretm82_upgraded_zm");
        insertWeapon("dsr50_upgraded_zm");
        insertWeapon("usrpg_zm");
        insertWeapon("ray_gun_zm");
        insertWeapon("raygun_mark2_zm");
        insertWeapon("usrpg_upgraded_zm");
        insertWeapon("ray_gun_upgraded_zm");
        insertWeapon("raygun_mark2_upgraded_zm");
        // self.weapons = strTok("m1911_zm,fiveseven_zm,beretta93r_zm,judge_zm,fivesevendw_zm,mp5k_zm,pdw57_zm,870mcs_zm,rottweil72_zm,saiga12_zm,tar21_zm,fnfal_zm,m14_zm,galil_zm,barretm82_zm,dsr50_zm,fiveseven_upgraded_zm,beretta93r_upgraded_zm,judge_upgraded_zm,fivesevendw_upgraded_zm,m1911_upgraded_zm,mp5k_upgraded_zm,pdw57_upgraded_zm,870mcs_upgraded_zm,rottweil72_upgraded_zm,saiga12_upgraded_zm,tar21_upgraded_zm,fnfal_upgraded_zm,m14_upgraded_zm,galil_upgraded_zm,barretm82_upgraded_zm,dsr50_upgraded_zm,usrpg_zm,ray_gun_zm,raygun_mark2_zm,usrpg_upgraded_zm,ray_gun_upgraded_zm,raygun_mark2_upgraded_zm", ","); /*This is the List of the weapons, u can change it to add or remove weapons*/
        break;
    case "processing":
        insertWeapon("m1911_zm");
        insertWeapon("fiveseven_zm");
        insertWeapon("beretta93r_zm");
        insertWeapon("judge_zm");
        insertWeapon("fivesevendw_zm");
        insertWeapon("mp5k_zm");
        insertWeapon("pdw57_zm");
        insertWeapon("870mcs_zm");
        insertWeapon("rottweil72_zm");
        insertWeapon("saiga12_zm");
        insertWeapon("tar21_zm");
        insertWeapon("fnfal_zm");
        insertWeapon("m14_zm");
        insertWeapon("galil_zm");
        insertWeapon("barretm82_zm");
        insertWeapon("dsr50_zm");
        insertWeapon("fiveseven_upgraded_zm");
        insertWeapon("beretta93r_upgraded_zm");
        insertWeapon("judge_upgraded_zm");
        insertWeapon("fivesevendw_upgraded_zm");
        insertWeapon("m1911_upgraded_zm");
        insertWeapon("mp5k_upgraded_zm");
        insertWeapon("pdw57_upgraded_zm");
        insertWeapon("870mcs_upgraded_zm");
        insertWeapon("rottweil72_upgraded_zm");
        insertWeapon("saiga12_upgraded_zm");
        insertWeapon("tar21_upgraded_zm");
        insertWeapon("fnfal_upgraded_zm");
        insertWeapon("m14_upgraded_zm");
        insertWeapon("galil_upgraded_zm");
        insertWeapon("barretm82_upgraded_zm");
        insertWeapon("dsr50_upgraded_zm");
        insertWeapon("usrpg_zm");
        insertWeapon("ray_gun_zm");
        insertWeapon("raygun_mark2_zm");
        insertWeapon("usrpg_upgraded_zm");
        insertWeapon("ray_gun_upgraded_zm");
        insertWeapon("raygun_mark2_upgraded_zm");
        // self.weapons = strTok("m1911_zm,fiveseven_zm,beretta93r_zm,judge_zm,fivesevendw_zm,mp5k_zm,pdw57_zm,870mcs_zm,rottweil72_zm,saiga12_zm,tar21_zm,fnfal_zm,m14_zm,galil_zm,barretm82_zm,dsr50_zm,fiveseven_upgraded_zm,beretta93r_upgraded_zm,judge_upgraded_zm,fivesevendw_upgraded_zm,m1911_upgraded_zm,mp5k_upgraded_zm,pdw57_upgraded_zm,870mcs_upgraded_zm,rottweil72_upgraded_zm,saiga12_upgraded_zm,tar21_upgraded_zm,fnfal_upgraded_zm,m14_upgraded_zm,galil_upgraded_zm,barretm82_upgraded_zm,dsr50_upgraded_zm,usrpg_zm,ray_gun_zm,raygun_mark2_zm,usrpg_upgraded_zm,ray_gun_upgraded_zm,raygun_mark2_upgraded_zm", ","); /*This is the List of the weapons, u can change it to add or remove weapons*/
        break;
    case "rooftop":
        insertWeapon("m1911_zm");
        insertWeapon("fiveseven_zm");
        insertWeapon("beretta93r_zm");
        insertWeapon("judge_zm");
        insertWeapon("fivesevendw_zm");
        insertWeapon("mp5k_zm");
        insertWeapon("pdw57_zm");
        insertWeapon("870mcs_zm");
        insertWeapon("rottweil72_zm");
        insertWeapon("saiga12_zm");
        insertWeapon("tar21_zm");
        insertWeapon("fnfal_zm");
        insertWeapon("m14_zm");
        insertWeapon("galil_zm");
        insertWeapon("barretm82_zm");
        insertWeapon("dsr50_zm");
        insertWeapon("fiveseven_upgraded_zm");
        insertWeapon("beretta93r_upgraded_zm");
        insertWeapon("judge_upgraded_zm");
        insertWeapon("fivesevendw_upgraded_zm");
        insertWeapon("m1911_upgraded_zm");
        insertWeapon("mp5k_upgraded_zm");
        insertWeapon("pdw57_upgraded_zm");
        insertWeapon("870mcs_upgraded_zm");
        insertWeapon("rottweil72_upgraded_zm");
        insertWeapon("saiga12_upgraded_zm");
        insertWeapon("tar21_upgraded_zm");
        insertWeapon("fnfal_upgraded_zm");
        insertWeapon("m14_upgraded_zm");
        insertWeapon("galil_upgraded_zm");
        insertWeapon("barretm82_upgraded_zm");
        insertWeapon("dsr50_upgraded_zm");
        insertWeapon("usrpg_zm");
        insertWeapon("ray_gun_zm");
        insertWeapon("raygun_mark2_zm");
        insertWeapon("usrpg_upgraded_zm");
        insertWeapon("ray_gun_upgraded_zm");
        insertWeapon("raygun_mark2_upgraded_zm");
        // self.weapons = strTok("m1911_zm,fiveseven_zm,beretta93r_zm,judge_zm,fivesevendw_zm,mp5k_zm,pdw57_zm,870mcs_zm,rottweil72_zm,saiga12_zm,tar21_zm,fnfal_zm,m14_zm,galil_zm,barretm82_zm,dsr50_zm,fiveseven_upgraded_zm,beretta93r_upgraded_zm,judge_upgraded_zm,fivesevendw_upgraded_zm,m1911_upgraded_zm,mp5k_upgraded_zm,pdw57_upgraded_zm,870mcs_upgraded_zm,rottweil72_upgraded_zm,saiga12_upgraded_zm,tar21_upgraded_zm,fnfal_upgraded_zm,m14_upgraded_zm,galil_upgraded_zm,barretm82_upgraded_zm,dsr50_upgraded_zm,usrpg_zm,ray_gun_zm,raygun_mark2_zm,usrpg_upgraded_zm,ray_gun_upgraded_zm,raygun_mark2_upgraded_zm", ","); /*This is the List of the weapons, u can change it to add or remove weapons*/
        break;
    case "nuked":
        insertWeapon("m1911_zm");
        insertWeapon("fiveseven_zm");
        insertWeapon("beretta93r_zm");
        insertWeapon("judge_zm");
        insertWeapon("fivesevendw_zm");
        insertWeapon("mp5k_zm");
        insertWeapon("870mcs_zm");
        insertWeapon("rottweil72_zm");
        insertWeapon("saiga12_zm");
        insertWeapon("tar21_zm");
        insertWeapon("fnfal_zm");
        insertWeapon("m14_zm");
        insertWeapon("galil_zm");
        insertWeapon("barretm82_zm");
        insertWeapon("dsr50_zm");
        insertWeapon("fiveseven_upgraded_zm");
        insertWeapon("beretta93r_upgraded_zm");
        insertWeapon("judge_upgraded_zm");
        insertWeapon("fivesevendw_upgraded_zm");
        insertWeapon("m1911_upgraded_zm");
        insertWeapon("mp5k_upgraded_zm");
        insertWeapon("pdw57_upgraded_zm");
        insertWeapon("870mcs_upgraded_zm");
        insertWeapon("rottweil72_upgraded_zm");
        insertWeapon("saiga12_upgraded_zm");
        insertWeapon("tar21_upgraded_zm");
        insertWeapon("fnfal_upgraded_zm");
        insertWeapon("m14_upgraded_zm");
        insertWeapon("galil_upgraded_zm");
        insertWeapon("barretm82_upgraded_zm");
        insertWeapon("dsr50_upgraded_zm");
        insertWeapon("usrpg_zm");
        insertWeapon("ray_gun_zm");
        insertWeapon("raygun_mark2_zm");
        insertWeapon("usrpg_upgraded_zm");
        insertWeapon("ray_gun_upgraded_zm");
        insertWeapon("raygun_mark2_upgraded_zm");
        // self.weapons = strTok("m1911_zm,fiveseven_zm,beretta93r_zm,judge_zm,fivesevendw_zm,mp5k_zm,870mcs_zm,rottweil72_zm,saiga12_zm,tar21_zm,fnfal_zm,m14_zm,galil_zm,barretm82_zm,dsr50_zm,fiveseven_upgraded_zm,beretta93r_upgraded_zm,judge_upgraded_zm,fivesevendw_upgraded_zm,m1911_upgraded_zm,mp5k_upgraded_zm,pdw57_upgraded_zm,870mcs_upgraded_zm,rottweil72_upgraded_zm,saiga12_upgraded_zm,tar21_upgraded_zm,fnfal_upgraded_zm,m14_upgraded_zm,galil_upgraded_zm,barretm82_upgraded_zm,dsr50_upgraded_zm,usrpg_zm,ray_gun_zm,raygun_mark2_zm,usrpg_upgraded_zm,ray_gun_upgraded_zm,raygun_mark2_upgraded_zm", ","); /*This is the List of the weapons, u can change it to add or remove weapons*/
        break;
    }
    level.ss_current = randomintrange(0, level.ss_weapons.size-1);

    flag_wait( "initial_blackscreen_passed" );
    flag_wait( "start_zombie_round_logic" );
    wait 1;
   
    level thread handleWeaponRotation();
}

main()
{
    replacefunc(maps\mp\zombies\_zm_magicbox::treasure_chest_init, ::empty_treasure_chest_init);
	replacefunc(maps\mp\zombies\_zm_weapons::weapon_spawn_think, ::empty_weapon_spawn_think);
}

empty_treasure_chest_init( start_chest_name ){}

empty_weapon_spawn_think(){}

handleWeaponRotation()
{
    chooseNextWeapon();
    start_x = 20;
    start_y = 170;

    // Hud by ZECxR3ap3r
    ss_hud = [];
    ss_hud["background"] = level createClientHudElement("fullscreen", "fullscreen", "left", "top", start_x - 10,start_y - 5, 0.3, 100, (0, 0, 0), "menu_zm_gamertag", 120, 55);
    ss_hud["gradient"] = level createClientHudElement("fullscreen", "fullscreen", "left", "top", start_x,start_y + 15, 0.9, -100, (0.31, 0, 0), "white", 67, 1); 
    ss_hud["title"] =  level createClientTextElement("fullscreen", "fullscreen", "left", "top", start_x,start_y, 1, 1, (1, 1, 1), 1.2, "Sharpshooter"); 
    ss_hud["next_gun_label"] =  level createClientTextElement("fullscreen", "fullscreen", "left", "top", start_x,start_y+17, 1, 1, (1, 1, 1), 1, "Next Gun: "); 
    ss_hud["next_gun_value"] =  level createClientTextElement("fullscreen", "fullscreen", "left", "top", start_x + 45, ss_hud["next_gun_label"].y, 1, 1, (1, 1, 1), 1); 
    ss_hud["next_gun_value"].label = &"";
    ss_hud["time_left_label"] =  level createClientTextElement("fullscreen", "fullscreen", "left", "top", start_x, ss_hud["next_gun_label"].y + 11, 1, 1, (1, 1, 1), 1, "Time: "); 
    ss_hud["time_left_value"] = level createClientTextElement("fullscreen", "fullscreen", "left", "top", start_x + 45, ss_hud["next_gun_label"].y + 11, 1, 1, (1, 1, 1), 1); 
    ss_hud["time_left_value"].label = &"";

    thread destroyHudsOnEndGame( ss_hud );

    //next_gun = self createFontString("objective", 1.2);
    //next_gun setPoint("LEFT", "LEFT", 0, -20);
    //requirement_next_gun = self createFontString("objective", 1.2);
    //requirement_next_gun setPoint("LEFT", "LEFT", 0, 0);

    //requirement_next_gun setValue(int(self.ss_requirement_target));
    //next_gun scripts\zm\overflowFix::setSafeText(self, "Next: " + getWeaponNameByID(level.ss_weapons[level.ss_current].weapon_id));
    ss_hud["time_left_value"] setValue(level.ss_time);
    ss_hud["next_gun_value"] scripts\zm\overflowFix::setSafeText(level, "^2" + getWeaponNameByID(level.ss_weapons[level.ss_next].weapon_id));

    type = 0; // infinite
    if(level.ss_rotation > 0)
    {
        type = 1; // count rotation (level.ss_rotation--)
    }
    while((level.ss_rotation > 0 && type == 1) || level.ss_rotation == 0)
    {
        ss_time = level.ss_time;
        while(ss_time > 0)
        {
            wait 1;
            ss_time--;
            ss_hud["time_left_value"] setValue(ss_time);
        }
        level.ss_current = level.ss_next;
        chooseNextWeapon();
        ss_hud["next_gun_value"] scripts\zm\overflowFix::setSafeText(level, "^2" + getWeaponNameByID(level.ss_weapons[level.ss_next].weapon_id));
        if(type == 1) 
        {
            level.ss_rotation--; 
            if(level.ss_rotation == 1)
            {
                ss_hud["next_gun_label"] scripts\zm\overflowFix::setSafeText(level, "");
                ss_hud["next_gun_value"] scripts\zm\overflowFix::setSafeText(level, "");
            }
        }
    }

    level notify("end_game");

    foreach (player in level.players)
    {
        player EnableInvulnerability();
        player FreezeControls(1);
    }
    
}

chooseNextWeapon()
{
    level.ss_next = randomintrange(0, level.ss_weapons.size-1);
    if(level.ss_next == level.ss_current) 
    {
        if(level.ss_next > 0) {
            level.ss_next++;
        } 
        else if(level.ss_next < level.ss_weapons.size-1)
        {
            level.ss_next--;
        }
    }
}

onPlayerConnect()
{
    for (;;)
    {
        level waittill("connected", player);
        player thread handleWeapons();
    }
}

player_is_in_laststand()
{
    if ( !( isdefined( self.no_revive_trigger ) && self.no_revive_trigger ) )
        return isdefined( self.revivetrigger );
    else
        return isdefined( self.laststand ) && self.laststand;
}

handleWeapons()
{
    self endon("disconnect");
    level endon("end_game");

    self waittill("spawned_player");
    self takeallweapons();
    self giveweapon(level.ss_weapons[level.ss_current].weapon_id);
    self SwitchToWeaponImmediate(level.ss_weapons[level.ss_current].weapon_id);
    type = 0; // infinite
    if(level.ss_rotation > 0)
    {
        type = 1; // count rotation (level.ss_rotation--)
    }
    while ((level.ss_rotation > 0 && type == 1) || level.ss_rotation == 0)
    {
        if (!self player_is_in_laststand() && ( !self HasWeapon(level.ss_weapons[level.ss_current].weapon_id) || (self GetCurrentWeapon() != level.ss_weapons[level.ss_current].weapon_id && isAValidWeapon(self GetCurrentWeapon()))) )
        {
            self takeallweapons();
            self giveweapon(level.ss_weapons[level.ss_current].weapon_id);
            self SwitchToWeaponImmediate(level.ss_weapons[level.ss_current].weapon_id);
        }
        self givemaxammo(self getCurrentWeapon());
        wait 0.05;
    }
}

createClientHudElement(horzalign, vertalign, alignx, aligny, x, y, alpha, sort, color, shader, width, height)
{
    hud = newhudelem();
    hud.horzalign = horzalign;
    hud.vertalign = vertalign;
    hud.alignx = alignx;
    hud.aligny = aligny;
    hud.x = x;
    hud.y = y;
    hud.alpha = alpha;
    hud.sort = sort;
    hud.color = color;
    hud setshader(shader, width, height);
    hud.hidewheninmenu = 1;
    return hud;
}

createClientTextElement(horzalign, vertalign, alignx, aligny, x, y, alpha, sort, color, fontscale, text)
{
    hud = newhudelem();
    hud.horzalign = horzalign;
    hud.vertalign = vertalign;
    hud.alignx = alignx;
    hud.aligny = aligny;
    hud.x = x;
    hud.y = y;
    hud.alpha = alpha;
    hud.sort = sort;
    hud.color = color;
    hud.hidewheninmenu = 1;
    hud.fontscale = fontscale;
    if(isDefined(text))
    {
        hud scripts\zm\overflowFix::setSafeText(self, text);
    }
    return hud;
}

destroyHudsOnEndGame( huds )
{
    level waittill("end_game");
    foreach(hud in huds)
    {
        hud destroy();
    }
}

// gg.gsc
insertWeapon(weapon_id)
{
    if (!isDefined(level.ss_weapons))
    {
        level.ss_weapons = [];
    }
    size = level.ss_weapons.size;
    level.ss_weapons[size] = SpawnStruct();
    level.ss_weapons[size].weapon_id = weapon_id;
}

getWeaponNameByID(weapon_id)
{
    weapon_name = getweapondisplayname(weapon_id);
    if (!isDefined(weapon_name) || weapon_name == "")
    {
        weapon_name = ToUpper(weaponclass(weapon_id));
    }
    return weapon_name;
}

isAValidWeapon(weapon_id)
{
    switch (weapon_id)
    {
    case "rifle":
    case "spread":
    case "SMG":
    case "pistol":
    case "MG":
    case "rocketlauncher":
    case "grenade":
        return 1;
    default:
        return 0;
    }
    return 0;
}
