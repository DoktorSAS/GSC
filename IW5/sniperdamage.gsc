#include common_scripts\utility;
#include maps\mp\_utility;

/*
    Mod: Sniper Damage for Modern Warfrare III Plutonium
    Developed by DoktorSAS
*/

init()
{	
    create_dvar( "sv_antiBulletSprays", 1 );
    level.antiBulletSprays = getDvarInt( "sv_antiBulletSprays" );
    level waittill("prematch_over");
    level.OriginalCallbackPlayerDamage = level.callbackPlayerDamage;
    level.callbackPlayerDamage = ::CodeCallback_PlayerDamage;
}

isSniper( weapon )
{
    return ( 
        isSubstr( weapon, "iw5_dragunov_mp") 
        ||  isSubstr( weapon, "iw5_msr_mp" ) 
        ||  isSubstr( weapon, "iw5_barrett_mp" ) 
        ||  isSubstr( weapon, "iw5_barrett_mp" ) 
        ||  isSubstr( weapon, "iw5_rsass_mp" ) 
        ||  isSubstr( weapon, "iw5_as50_mp" ) 
        ||  isSubstr( weapon, "iw5_l96a1_mp")
        ||  isSubstr( weapon, "iw5_cheytac_mp")
    );
}

CodeCallback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset)
{
	  self endon("disconnect");
    if(sMeansOfDeath == "MOD_TRIGGER_HURT" || sMeansOfDeath == "MOD_HIT_BY_OBJECT" ||sMeansOfDeath == "MOD_SUICIDE" || sMeansOfDeath == "MOD_FALLING" )
	  {
        [[level.OriginalCallbackPlayerDamage]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
    }
    else
    {
        if( isSniper( sWeapon ) )
        {
            if(level.antiBulletSprays && eAttacker.__vars["already_fired"])
                iDamage = 0;
            else 
                iDamage = 999;  
        }
        else 
            iDamage = 0;

            
        if( sMeansOfDeath == "MOD_MELEE") // Disable Melee damages
            iDamage = 0;
        
        [[level.OriginalCallbackPlayerDamage]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
    }		
}

