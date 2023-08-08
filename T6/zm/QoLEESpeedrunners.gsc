#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\_utility;

/*
    Mod: QoL for speedrunners
    Developed by DoktorSAS

    Description:
    This mod will restore the locker to a specified guns and it will maxout the bank
*/

init()
{
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for (;;)
    {
        level waittill("connected", player);
        restoreLocker();
        maxoutBank();
    }
}

restoreLocker()
{
    self set_map_weaponlocker_stat("name", "weapon_mp", level.script);
    self set_map_weaponlocker_stat("lh_clip", 0, level.script);
    self set_map_weaponlocker_stat("clip", 0, level.script);
    self set_map_weaponlocker_stat("stock", 0, level.script);
    self set_map_weaponlocker_stat("alt_clip", 0, level.script);
    self set_map_weaponlocker_stat("alt_stock", 0, level.script);
}

maxoutBank()
{
    self.account_value = level.bank_deposit_max_amount
}
