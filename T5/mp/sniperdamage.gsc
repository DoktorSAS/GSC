#include common_scripts\utility;
#include maps\mp\_utility;

/*
    Mod: Sniper Damages for Black ops Plutonium
    Developed by DoktorSAS
*/

init()
{	
    level.onPlayerDamage = ::onPlayerDamage;
}


onPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset)
{
    if(sMeansOfDeath == "MOD_TRIGGER_HURT" || sMeansOfDeath == "MOD_HIT_BY_OBJECT" || sMeansOfDeath == "MOD_SUICIDE" || sMeansOfDeath == "MOD_FALLING" )
    {
        return iDamage;
    }
    else
    {
        if( maps\mp\gametypes\_missions::getWeaponClass( sWeapon ) == "weapon_sniper" || sWeapon == "hatchet_mp" )
        {
            iDamage = 999;  
        }
        else 
        {
            self.health += iDamage;
            iDamage = 0;
        }
            
        if( sMeansOfDeath == "MOD_MELEE") // Disable Melee damages
            iDamage = 0;
        
        return iDamage;
    }		
}
