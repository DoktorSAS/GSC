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
    /*
        Change "weapon_mp" with the id of the weapon you want to use.
        Then replace the 999 with the ammo you want in those space:
            - lh_clip stand for left hand clip
            - clip stand for normal ammo clip
            - stock stand for ammo in the stock
            - alt_clip probably is for special weapons (tbh idk)
            - alt_stock probably is for special weapons (tbh idk)
    */
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
