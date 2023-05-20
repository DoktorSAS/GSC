#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\zombies\_zm;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;

/*
    Mod: GunGame
    Developed by @DoktorSAS
*/
init()
{
    level thread onPlayerConnect();

    level.gg_rotation = 1; // Set to 0 for infinite rotation
    map = getDvar("ui_zm_mapstartlocation");
    switch(map)
    {
        case "town":
            insertWeapon("m1911_zm");
            insertWeapon("fiveseven_zm");
            insertWeapon("beretta93r_zm");
            insertWeapon("judge_zm");
            insertWeapon("fivesevendw_zm");
            insertWeapon("mp5k_zm");
            insertWeapon("870mcs_zm");
            insertWeapon("rottweil72_zm");
            //self.weapons = strTok("m1911_zm,fiveseven_zm,beretta93r_zm,judge_zm,fivesevendw_zm,mp5k_zm,870mcs_zm,rottweil72_zm,saiga12_zm,tar21_zm,fnfal_zm,m14_zm,galil_zm,barretm82_zm,dsr50_zm,fiveseven_upgraded_zm,beretta93r_upgraded_zm,judge_upgraded_zm,fivesevendw_upgraded_zm,m1911_upgraded_zm,mp5k_upgraded_zm,870mcs_upgraded_zm,rottweil72_upgraded_zm,saiga12_upgraded_zm,tar21_upgraded_zm,fnfal_upgraded_zm,m14_upgraded_zm,galil_upgraded_zm,barretm82_upgraded_zm,dsr50_upgraded_zm", ","); /*This is the List of the weapons, u can change it to add or remove weapons*/
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
            //self.weapons = strTok("m1911_zm,fiveseven_zm,beretta93r_zm,judge_zm,fivesevendw_zm,mp5k_zm,pdw57_zm,870mcs_zm,rottweil72_zm,saiga12_zm,tar21_zm,fnfal_zm,m14_zm,galil_zm,barretm82_zm,dsr50_zm,fiveseven_upgraded_zm,beretta93r_upgraded_zm,judge_upgraded_zm,fivesevendw_upgraded_zm,m1911_upgraded_zm,mp5k_upgraded_zm,pdw57_upgraded_zm,870mcs_upgraded_zm,rottweil72_upgraded_zm,saiga12_upgraded_zm,tar21_upgraded_zm,fnfal_upgraded_zm,m14_upgraded_zm,galil_upgraded_zm,barretm82_upgraded_zm,dsr50_upgraded_zm,usrpg_zm,ray_gun_zm,raygun_mark2_zm,usrpg_upgraded_zm,ray_gun_upgraded_zm,raygun_mark2_upgraded_zm", ","); /*This is the List of the weapons, u can change it to add or remove weapons*/
            break;
        case "tomb":
            insertWeapon("c96_zm");
            insertWeapon("fiveseven_zm");
            insertWeapon("beretta93r_zm");
            insertWeapon("judge_zm");
            insertWeapon("fivesevendw_zm");
            insertWeapon("mp40_zm");
            insertWeapon("pdw57_zm");
            insertWeapon("870mcs_zm");
            //self.weapons = strTok("c96_zm,fiveseven_zm,beretta93r_zm,fivesevendw_zm,mp40_zm,pdw57_zm,870mcs_zm,fnfal_zm,m14_zm,galil_zm,dsr50_zm,fiveseven_upgraded_zm,beretta93r_upgraded_zm,fivesevendw_upgraded_zm,c96_upgraded_zm,mp40_upgraded_zm,pdw57_upgraded_zm,870mcs_upgraded_zm,fnfal_upgraded_zm,m14_upgraded_zm,galil_upgraded_zm,dsr50_upgraded_zm,ray_gun_zm,raygun_mark2_zm,ray_gun_upgraded_zm,raygun_mark2_upgraded_zm", ","); /*This is the List of the weapons, u can change it to add or remove weapons*/
            break;
        case "farm":
            insertWeapon("m1911_zm");
            insertWeapon("fiveseven_zm");
            insertWeapon("beretta93r_zm");
            insertWeapon("judge_zm");
            insertWeapon("fivesevendw_zm");
            insertWeapon("mp40_zm");
            insertWeapon("pdw57_zm");
            insertWeapon("870mcs_zm");
            //self.weapons = strTok("m1911_zm,fiveseven_zm,beretta93r_zm,judge_zm,fivesevendw_zm,mp5k_zm,pdw57_zm,870mcs_zm,rottweil72_zm,saiga12_zm,tar21_zm,fnfal_zm,m14_zm,galil_zm,barretm82_zm,dsr50_zm,fiveseven_upgraded_zm,beretta93r_upgraded_zm,judge_upgraded_zm,fivesevendw_upgraded_zm,m1911_upgraded_zm,mp5k_upgraded_zm,pdw57_upgraded_zm,870mcs_upgraded_zm,rottweil72_upgraded_zm,saiga12_upgraded_zm,tar21_upgraded_zm,fnfal_upgraded_zm,m14_upgraded_zm,galil_upgraded_zm,barretm82_upgraded_zm,dsr50_upgraded_zm,usrpg_zm,ray_gun_zm,raygun_mark2_zm,usrpg_upgraded_zm,ray_gun_upgraded_zm,raygun_mark2_upgraded_zm", ","); /*This is the List of the weapons, u can change it to add or remove weapons*/
            break;
        case "processing":
            insertWeapon("m1911_zm");
            insertWeapon("fiveseven_zm");
            insertWeapon("beretta93r_zm");
            insertWeapon("judge_zm");
            insertWeapon("fivesevendw_zm");
            insertWeapon("mp40_zm");
            insertWeapon("pdw57_zm");
            insertWeapon("870mcs_zm");
            //self.weapons = strTok("m1911_zm,fiveseven_zm,beretta93r_zm,judge_zm,fivesevendw_zm,mp5k_zm,pdw57_zm,870mcs_zm,rottweil72_zm,saiga12_zm,tar21_zm,fnfal_zm,m14_zm,galil_zm,barretm82_zm,dsr50_zm,fiveseven_upgraded_zm,beretta93r_upgraded_zm,judge_upgraded_zm,fivesevendw_upgraded_zm,m1911_upgraded_zm,mp5k_upgraded_zm,pdw57_upgraded_zm,870mcs_upgraded_zm,rottweil72_upgraded_zm,saiga12_upgraded_zm,tar21_upgraded_zm,fnfal_upgraded_zm,m14_upgraded_zm,galil_upgraded_zm,barretm82_upgraded_zm,dsr50_upgraded_zm,usrpg_zm,ray_gun_zm,raygun_mark2_zm,usrpg_upgraded_zm,ray_gun_upgraded_zm,raygun_mark2_upgraded_zm", ","); /*This is the List of the weapons, u can change it to add or remove weapons*/
            break;
        case "rooftop":
            insertWeapon("m1911_zm");
            insertWeapon("fiveseven_zm");
            insertWeapon("beretta93r_zm");
            insertWeapon("judge_zm");
            insertWeapon("fivesevendw_zm");
            insertWeapon("mp40_zm");
            insertWeapon("pdw57_zm");
            insertWeapon("870mcs_zm");
            //self.weapons = strTok("m1911_zm,fiveseven_zm,beretta93r_zm,judge_zm,fivesevendw_zm,mp5k_zm,pdw57_zm,870mcs_zm,rottweil72_zm,saiga12_zm,tar21_zm,fnfal_zm,m14_zm,galil_zm,barretm82_zm,dsr50_zm,fiveseven_upgraded_zm,beretta93r_upgraded_zm,judge_upgraded_zm,fivesevendw_upgraded_zm,m1911_upgraded_zm,mp5k_upgraded_zm,pdw57_upgraded_zm,870mcs_upgraded_zm,rottweil72_upgraded_zm,saiga12_upgraded_zm,tar21_upgraded_zm,fnfal_upgraded_zm,m14_upgraded_zm,galil_upgraded_zm,barretm82_upgraded_zm,dsr50_upgraded_zm,usrpg_zm,ray_gun_zm,raygun_mark2_zm,usrpg_upgraded_zm,ray_gun_upgraded_zm,raygun_mark2_upgraded_zm", ","); /*This is the List of the weapons, u can change it to add or remove weapons*/
            break;
        case "nuked":
            insertWeapon("m1911_zm");
            insertWeapon("fiveseven_zm");
            insertWeapon("beretta93r_zm");
            insertWeapon("judge_zm");
            insertWeapon("fivesevendw_zm");
            insertWeapon("mp40_zm");
            insertWeapon("pdw57_zm");
            insertWeapon("870mcs_zm");
            //self.weapons = strTok("m1911_zm,fiveseven_zm,beretta93r_zm,judge_zm,fivesevendw_zm,mp5k_zm,870mcs_zm,rottweil72_zm,saiga12_zm,tar21_zm,fnfal_zm,m14_zm,galil_zm,barretm82_zm,dsr50_zm,fiveseven_upgraded_zm,beretta93r_upgraded_zm,judge_upgraded_zm,fivesevendw_upgraded_zm,m1911_upgraded_zm,mp5k_upgraded_zm,pdw57_upgraded_zm,870mcs_upgraded_zm,rottweil72_upgraded_zm,saiga12_upgraded_zm,tar21_upgraded_zm,fnfal_upgraded_zm,m14_upgraded_zm,galil_upgraded_zm,barretm82_upgraded_zm,dsr50_upgraded_zm,usrpg_zm,ray_gun_zm,raygun_mark2_zm,usrpg_upgraded_zm,ray_gun_upgraded_zm,raygun_mark2_upgraded_zm", ","); /*This is the List of the weapons, u can change it to add or remove weapons*/
            break;
    }

}


onPlayerConnect()
{
	for (;;)
	{
		level waittill("connected", player);
        player.gg_index = 0;
        player.gg_kills_target = int(level.gg_weapons[player.gg_index].kills);
		player thread handlePlayerHUD();
        player thread handleWeapons();
	}
}

handleWeapons()
{
    self endon("disconnect");
    level endon("end_game");

    self waittill("spawned_player");
    self takeallweapons();
    self giveweapon(level.gg_weapons[self.gg_index].weapon_id);
	self SwitchToWeaponImmediate(level.gg_weapons[self.gg_index].weapon_id);
    while(self.gg_rotation > 0 && level.gg_rotation > 0)
    {
        if(self GetCurrentWeapon() != level.gg_weapons[self.gg_index].weapon_id && isAValidWeapon(self GetCurrentWeapon()))
        {
            self IPrintLn("^1Don't^7 try to ^6cheat^7!");
            self takeallweapons();
            self giveweapon(level.gg_weapons[self.gg_index].weapon_id);
			self SwitchToWeaponImmediate(level.gg_weapons[self.gg_index].weapon_id);
        }
        self givemaxammo(self getCurrentWeapon());
        wait 0.2;
    }
}

handlePlayerHUD()
{
    self endon("disconnect");
    level endon("end_game");
    next_gun = self createFontString("objective", 1.2);
	next_gun setPoint("LEFT", "LEFT", 0, -20);
	kills_for_next_gun = self createFontString("objective", 1.2);
	kills_for_next_gun setPoint("LEFT", "LEFT", 0, 0);
    kills_for_next_gun.label = &"Kills: ";

    kills_for_next_gun setValue( int(self.gg_kills_target) );
    next_gun setText( "Next: " + getWeaponNameByID(level.gg_weapons[self.gg_index].weapon_id) );
    if(level.gg_rotation > 0)
    {
        self.gg_rotation = level.gg_rotation;
    }
    kills_before = 0;
    while(self.gg_rotation > 0 && level.gg_rotation > 0)
    {
        level waittill( "zom_kill" );
        if(isDefined(self.kills) && self.kills > 0 && kills_before != self.kills)
        {
            dif = self.kills - kills_before;
            kills_before = self.kills;
            self.gg_kills_target = self.gg_kills_target - dif;
            if(self.gg_kills_target < 0)
            {
                self.gg_kills_target = 0;
            }
            kills_for_next_gun setValue( int(self.gg_kills_target) );

            if(self.gg_kills_target == 0)
            {
                if(self.gg_index < level.gg_weapons.size-1)
                {
                    self.gg_index = self.gg_index + 1;
                    self.gg_kills_target = int(level.gg_weapons[self.gg_index].kills);
                    kills_for_next_gun setValue( int(self.gg_kills_target) );
                    next_gun setText( "Next: " + getWeaponNameByID(level.gg_weapons[self.gg_index].weapon_id) );
                    self takeallweapons();
                    self giveweapon(level.gg_weapons[self.gg_index].weapon_id);
                    self SwitchToWeaponImmediate(level.gg_weapons[self.gg_index].weapon_id);
                }
                else
                {
                    self.gg_rotation--;
                }
            }
        }
    }
    level notify("end_game");
}

// gg.gsc
insertWeapon(weapon_id, kills)
{
    if(!isDefined(level.gg_weapons))
    {
        level.gg_weapons = [];
    }
    if(!isDefined(kills))
    {
        kills = 10;
        switch ( weaponclass( weapon_id ) )
        {
            case "rifle":
                kills = 2;
                break;
            case "spread":
            case "smg":
                kills = 2;
                break;
            case "pistol":
                kills = 1;
                break;
            case "mg":
                kills = 4;
                break;
            case "rocketlauncher":
            case "grenade":
                kills = 3;
                break;
        }
    }
    size = level.gg_weapons.size;
    level.gg_weapons[size] = SpawnStruct();
    level.gg_weapons[size].weapon_id = weapon_id;
    level.gg_weapons[size].kills = kills;
}

getWeaponNameByID( weapon_id )
{
    switch(weapon_id)
    {
        case "rifle":
            return "RIFLE";
        case "spread":
            return "SPREAD";
        case "SMG":
            return "SMG";
        case "pistol":
            return "PISTOL";
        case "MG":
            return "MG";
        case "rocketlauncher":
            return "ROCKETLAUNCHER";
        case "grenade":
            return "GRANADE";
        default:
            return  getWeaponNameByID( weaponclass( weapon_id ) );
    }
    return  weaponclass( weapon_id );
}


isAValidWeapon( weapon_id )
{
    switch(weapon_id)
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
