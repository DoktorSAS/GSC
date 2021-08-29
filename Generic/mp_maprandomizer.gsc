#include common_scripts\utility;
#include maps\mp\_utility;

/*
    Mod: Map Randomizer
    Clints Supported: T4, T5, T6, IW3, IW5, IW5
    Deveoped by @DoktorSAS
*/

init()
{ 

    level.cod_client = getClient();

    _setDvarIfNotUnizialized("sv_gm_maps", getDefaultMaps( level.cod_client ) );
    maps = strTok(getDvar("sv_gm_maps"), " ");
    
    switch(level.cod_client)
    {
       case "IW3":
            _setDvarIfNotUnizialized("sv_gm_gametype", "dm");
            gametype = getDvar("sv_gm_gametype");
            setDvar("sv_maprotation", "gametype " + gametype + " map " + maps[ randomintrange(0, maps.size-1) ] );
        break;
        case "IW4":
            if(getDvar("sv_gm_cfg") != "")
                setDvar("sv_maprotation",  getDvar("sv_gm_cfg") + " map " + maps[ randomintrange(0, maps.size-1) ] );
            else
                setDvar("sv_maprotation", "map " + maps[ randomintrange(0, maps.size-1) ] );
        break;
        case "IW5":
             _setDvarIfNotUnizialized("sv_gm_dsr", "FFA_default");
             dsr = getDvar("sv_gm_dsr");
             setDvar("sv_maprotation", "dsr " + dsr + " map " + maps[ randomintrange(0, maps.size-1) ] );
        break;
        case "T4":
            _setDvarIfNotUnizialized("sv_gm_gametype", "tdm");
            gametype = getDvar("sv_gm_gametype");
            setDvar("sv_maprotation", "gametype " + gametype + " map " + maps[ randomintrange(0, maps.size-1) ] );
        break;
        case "T5":
            setDvar("sv_maprotation", "map " + maps[ randomintrange(0, maps.size-1) ] );
        break;
        case "T6":
            if(getDvar("sv_gm_cfg") != "")
                setDvar("sv_maprotation",  getDvar("sv_gm_cfg") + " map " + maps[ randomintrange(0, maps.size-1) ] );
            else
                setDvar("sv_maprotation", "map " + maps[ randomintrange(0, maps.size-1) ] );
        break;
    }
}


getDefaultMaps( client )
{
    maps = "Not valid maps for this client";
    switch( client )
    {
        case "IW3":
            maps = "mp_backlot mp_block mp_broadcast gametype sd mp_shipment mp_countdown gametype dom mp_backlot mp_shipment";   
        break;
        case "IW4":
            maps = "mp_afghan mp_boneyard mp_brecourt mp_checkpoint mp_derail mp_estate mp_favela mp_highrise mp_invasion mp_nightshift mp_quarry mp_rundown mp_rust mp_subbase mp_terminal mp_underpass mp_compact mp_complex mp_crash mp_overgrown mp_storm mp_strike mp_vacant mp_fuel2 mp_abandon mp_trailerpark";   
        break;
        case "IW5":
            maps = "mp_rust mp_terminal_cls mp_alpha mp_bootleg mp_bravo mp_carbon mp_dome mp_exchange mp_hardhat mp_interchange mp_lambeth mp_mogadishu mp_paris mp_plaza2 mp_radar mp_seatown mp_underground mp_village";
        break;
        case "T4":
            maps = "mp_castle mp_makin mp_roundhouse mp_asylum mp_airfield mp_seelow mp_dome mp_downfall mp_suburban mp_shrine mp_outskirts mp_hangar mp_courtyard";
        break;
        case "T5":
            maps = "mp_array mp_cracked mp_crisis mp_firingrange mp_duga mp_hanoi mp_cairo mp_havoc mp_cosmodrome mp_nuked mp_radiation mp_mountain mp_villa mp_russianbase mp_berlinwall2 mp_discovery mp_kowloon mp_stadium mp_gridlock mp_hotel mp_outskirts mp_zoo mp_drivein mp_area51 mp_golfcourse mp_silo";
        break;
        case "T6":
            maps = "mp_la mp_dockside mp_carrier mp_drone mp_express mp_hijacked mp_meltdown mp_overflow mp_nightclub mp_raid mp_slums mp_village mp_turbine mp_socotra mp_nuketown_2020";
        break;
    }
    return maps;
}

getClient()
{
    result = "Not valid cod client";
    version = getDvar("version");
    switch( version )
    {
        case "CoD4 MP 19.0 win_minw-x86 Dec 12 2020":
            result = "IW3";
        break;
        case "IW4x (v0.6.1)":
            result = "IW4";
        break;
        case "IW5 MP 1.9 build 388110 Fri Sep 14 00:04:28 2012 win-x86":
            result = "IW5";
        break;
        case "Plutonium T4^7":
            result = "T4";
        break;
         case "Call of Duty Multiplayer - Ship COD_T%_S MP build 7.0.189 CL(1022875) CODPCAB-V64 CEG Wed Nov 02 10:02:23 2011 win-x86 default: ":
            result = "T5";
        break;
        case "Call of Duty Multiplayer - Ship COD_T6_S MP build 1.0.44 CL(1759941) CODPCAB2 CEG Fri May 9 19:19:19 2014 win-x86 813e66d5":
            result = "T6";
        break;
      
      
    }

    if( isSubStr(version, "CoD4")) 
        result = "IW3";
    else if( isSubStr(version, "IW4")) 
        result = "IW4"; 
    else if( isSubStr(version, "IW5")) 
        result = "IW5";
    else if( isSubStr(version, "T4")) 
        result = "T4";
    else if( isSubStr(version, "T5")) 
        result = "T5"; 
    else if( isSubStr(version, "T6")) 
        result = "T6"; 

    return result;
       
}


_setDvarIfNotUnizialized(dvar, value)
{
    if( getDvar(dvar) == "" )
        setDvar(dvar, value);
}

