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
    level.gg_scorebased = 1;
    map = getDvar("ui_zm_mapstartlocation");
    switch (map)
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
}

onPlayerConnect()
{
    for (;;)
    {
        level waittill("connected", player);
        player.gg_index = 0;
        player.gg_rotation = level.gg_rotation;
        player.gg_requirement_target = int(level.gg_weapons[player.gg_index].requirement);

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
    while (self.gg_rotation > 0 && level.gg_rotation > 0)
    {
        if (self GetCurrentWeapon() != level.gg_weapons[self.gg_index].weapon_id && isAValidWeapon(self GetCurrentWeapon()))
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
    requirement_next_gun = self createFontString("objective", 1.2);
    requirement_next_gun setPoint("LEFT", "LEFT", 0, 0);

    requirement_next_gun setValue(int(self.gg_requirement_target));
    next_gun setText("Next: " + getWeaponNameByID(level.gg_weapons[self.gg_index].weapon_id));
    kills_before = 0;

    if (level.gg_scorebased)
    {
        requirement_next_gun.label = &"Score: ";
        score_before = self.score;
        while (self.gg_rotation > 0 && level.gg_rotation > 0)
        {
            if (isDefined(self.score) && self.score > 0 && score_before != self.score)
            {
                dif = self.score - score_before;
                score_before = self.score;
                self.gg_requirement_target = self.gg_requirement_target - dif;
                if (self.gg_requirement_target < 0)
                {
                    self.gg_requirement_target = 0;
                }
                requirement_next_gun setValue(int(self.gg_requirement_target));
                if (self.gg_requirement_target == 0)
                {
                    if (self.gg_index < level.gg_weapons.size - 1)
                    {
                        self.gg_index = self.gg_index + 1;
                        self.gg_requirement_target = int(level.gg_weapons[self.gg_index].requirement);
                        requirement_next_gun setValue(int(self.gg_requirement_target));
                        next_gun setText("Next: " + getWeaponNameByID(level.gg_weapons[self.gg_index+1].weapon_id));
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
            wait 0.2;
        }
    }
    else
    {
        requirement_next_gun.label = &"Kills: ";
        while (self.gg_rotation > 0 && level.gg_rotation > 0)
        {
            level waittill("zom_kill");
            if (isDefined(self.kills) && self.kills > 0 && kills_before != self.kills)
            {
                dif = self.kills - kills_before;
                kills_before = self.kills;
                self.gg_requirement_target = self.gg_requirement_target - dif;
                if (self.gg_requirement_target < 0)
                {
                    self.gg_requirement_target = 0;
                }
                requirement_next_gun setValue(int(self.gg_requirement_target));

                if (self.gg_requirement_target == 0)
                {
                    if (self.gg_index < level.gg_weapons.size - 1)
                    {
                        self.gg_index = self.gg_index + 1;
                        self.gg_requirement_target = int(level.gg_weapons[self.gg_index].requirement);
                        requirement_next_gun setValue(int(self.gg_requirement_target));
                        next_gun setText("Next: " + getWeaponNameByID(level.gg_weapons[self.gg_index+1].weapon_id));
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
    }
    level notify("end_game");
}

// gg.gsc
insertWeapon(weapon_id, requirement)
{
    /*
        requirement: if level.gg_scorebased is set to 1 requirement will mean "How many points a player need" if level.gg_scorebased is set to 0 it mean "How many kills a player need"
    */
    if (!isDefined(level.gg_weapons))
    {
        level.gg_weapons = [];
    }

    if (!isDefined(requirement))
    {
        if (level.gg_scorebased)
        {
            requirement = 1000;
            switch (weaponclass(weapon_id))
            {
            case "rifle":
                requirement = 2000;
                break;
            case "spread":
            case "smg":
                requirement = 2500;
                break;
            case "pistol":
                requirement = 1000;
                break;
            case "mg":
                requirement = 4000;
                break;
            case "rocketlauncher":
            case "grenade":
                requirement = 3000;
                break;
            }
        }
        else
        {
            requirement = 10;
            switch (weaponclass(weapon_id))
            {
            case "rifle":
                requirement = 20;
                break;
            case "spread":
            case "smg":
                requirement = 25;
                break;
            case "pistol":
                requirement = 10;
                break;
            case "mg":
                requirement = 40;
                break;
            case "rocketlauncher":
            case "grenade":
                requirement = 30;
                break;
            }
        }
    }
    size = level.gg_weapons.size;
    level.gg_weapons[size] = SpawnStruct();
    level.gg_weapons[size].weapon_id = weapon_id;
    level.gg_weapons[size].requirement = requirement;
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
