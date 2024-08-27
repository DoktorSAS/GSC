#include common_scripts\utility;
#include maps\mp\_utility;

init()
{
    thread onPlayerConnect();
}

codecallback_playerdamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime)
{
    _iDamage = iDamage;
    if (sMeansOfDeath == "MOD_MELEE")
    {
        //_iDamage = 0;
        return;
    }
        

    if(tolower(weaponclass( sWeapon )) == "sniper")
    {
        _iDamage = 999;
    } 
    else if (!sMeansOfDeath == "MOD_TRIGGER_HURT" && !sMeansOfDeath == "MOD_SUICIDE" && !sMeansOfDeath == "MOD_FALLING")
    {
        //_iDamage = 0;
        return;
    }

   [[level.callbackplayerdamage_stub]] (eInflictor, eAttacker, _iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, psOffsetTime);
}

onPlayerConnect()
{
    once = 1;
    for (;;)
    {
        level waittill("connected", player);
        if (once)
        {
            level.callbackplayerdamage_stub = level.callbackplayerdamage;
            level.callbackplayerdamage = ::codecallback_playerdamage;
            once = 0;
        }
    }
}
