#include common_scripts\utility;
#include maps\mp\_utility;

#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;

// zm_cperks.gsc

/*
    Mod: zm_cperks.gsc
    Developed by @DoktorSAS
    
    Description:
    This script its just an utils to drag and drop custom perks.

    level._custom_perks[str_perk].alias = str_perk;
    level._custom_perks[str_perk].cost = n_perk_cost;
    level._custom_perks[str_perk].hint_string = str_hint_string;
    level._custom_perks[str_perk].perk_bottle = str_perk_bottle_weapon;
    maps\mp\zombies\_zm_perks::register_perk_basic_info( "specialty_flakjacket", "divetonuke", 2000, &"ZOMBIE_PERK_DIVETONUKE", "zombie_perk_bottle_nuke" );

    level._custom_perks[str_perk].clientfield_register = func_clientfield_register;
    level._custom_perks[str_perk].clientfield_set = func_clientfield_set;
    maps\mp\zombies\_zm_perks::register_perk_clientfields( "specialty_flakjacket", ::divetonuke_register_clientfield, ::divetonuke_set_clientfield );

    level._custom_perks[str_perk].perk_machine_set_kvps = func_perk_machine_setup;
    level._custom_perks[str_perk].perk_machine_thread = func_perk_machine_thread;
    maps\mp\zombies\_zm_perks::register_perk_machine( "specialty_flakjacket", ::divetonuke_perk_machine_setup, ::divetonuke_perk_machine_think );

    level._custom_perks[str_perk].host_migration_func = func_host_migration;
    maps\mp\zombies\_zm_perks::register_perk_host_migration_func( "specialty_flakjacket", ::divetonuke_host_migration_func );
*/


init()
{
    //printf("zm_cperks.gsc");
    /*
        Guide:
        1. Place your custom perk script in scripts\zm\cperks folder
        2. Call in the init method of yout custom perks before flag_wait( "initial_blackscreen_passed" ); 
        Exemple with ammoregen.gsc
        thread scripts\zm\cperks\ammoregen::init();
    */
    //thread scripts\zm\cperks\test_cperk::init();
    thread scripts\zm\cperks\money_equal_power::init();

    level thread onPlayerConnect();

    flag_wait( "initial_blackscreen_passed" );
    cperk_precache();
    cperk_think();

    level.callbackactordamage_original = level.callbackactordamage;
    level.callbackactordamage = ::actor_damage_override_wrapper;
    
}

actor_damage_override_wrapper( inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex )
{
    [[level.callbackactordamage_original]]( inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex );
    foreach(cperks in level._custom_cperks)
    {
        //printf("actor_damage_override_wrapper " + cperks.alias);
        thread [[cperks.callback_on_actor_damage_func]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
    }
}

onPlayerConnect()
{
    for (;;)
    {
        level waittill("connected", player);
        player thread cperk_handle_loseperks();
        player thread cperks_handle_ui();
    }
}

clientdrawshader( shader, x, y, width, height, color, alpha, sort )
{
	hud = newclienthudelem( self );
	hud.elemtype = "icon";
	hud.color = color;
	hud.alpha = alpha;
	hud.sort = sort;
	hud.children = [];
	hud setparent( level.uiparent );
	hud setshader( shader, width, height );
	hud.x = x;
	hud.y = y;
    hud.hidewheninmenu = 1;
	return hud;
}

affectElement(type, time, value)
{
    if(type == "x" || type == "y")
        self moveOverTime(time);
    else
        self fadeOverTime(time);
    if(type == "x")
        self.x = value;
    if(type == "y")
        self.y = value;
    if(type == "alpha")
        self.alpha = value;
    if(type == "color")
        self.color = value;
}

cperks_handle_ui()
{
    self endon("disconnect");
    level endon("end_game");
    level endon("clear_server");
    hud = [];
    for(i = 0; i < level._custom_cperks.size; i++)
    {
        hud[i] = self clientdrawshader( "white", -350 + (30*i), 0, 25, 25, ( 1, 1, 1), 0, 100 );
    }

    for(;;)
    {
        self waittill("update_cperk_ui", cperk_id);
        if(!isDefined(cperk_id))
        {
            for(i = 0; i < level._custom_cperks.size; i++)
            {
                hud[i] affectElement("alpha", 0, 0);
            }
        }
        else
        {
            index = self.cperks.size-1;
            hud[index] setShader(level.machine_assets[cperk_id].icon, 25, 25);
            if(isDefined(level.machine_assets[cperk_id].iconColor))
            {
                hud[index].color = level.machine_assets[cperk_id].iconColor;
            }
            hud[index] affectElement("alpha", 1, 1);
        }
    }
}

cperk_handle_loseperks()
{
    self endon("disconnect");
    level endon("end_game");
    for(;;)
    {
        event = self waittill_any_return( "player_suicide", "zombified", "death", "player_downed");
        self.cperks = [];
        self notify("cperk_lost");
        self notify("update_cperk_ui");
        foreach(cperks in level._custom_cperks)
        {
            //printf("cperk_handle_loseperks " + cperks.alias);
            thread [[cperks.on_perk_lost_func]]();
        }
    }
}

turn_cperk_off()
{
    self.effect delete();
    self notify( "stop_loopsound" );
}

default_give_perk()
{
    self IPrintLnBold("You got the ^3perk^7!");
}

drink_and_give(cperk_id, player, perk)
{
    player endon( "disconnect" );
	level endon("end_game");
    player endon( "perk_abort_drinking" );
    gun = player maps\mp\zombies\_zm_perks::perk_give_bottle_begin( perk );
    evt = player waittill_any_return( "fake_death", "death", "player_downed", "weapon_change_complete" );
    player maps\mp\zombies\_zm_perks::perk_give_bottle_end( gun, perk );
    if (player maps\mp\zombies\_zm_laststand::player_is_in_laststand() || isDefined( player.intermission ) && player.intermission)
    {
        return;
    }
    player notify( "burp" );
    if ( isDefined( level.pers_upgrade_cash_back ) && level.pers_upgrade_cash_back)
    {
        player maps\mp\zombies\_zm_pers_upgrades_functions::cash_back_player_drinks_perk();
    }
    if(isDefined(level.pers_upgrade_perk_lose) && level.pers_upgrade_perk_lose)
    {
        player thread maps\mp\zombies\_zm_pers_upgrades_functions::pers_upgrade_perk_lose_bought();
    }
    if(isDefined( level.perk_bought_func ))
    {
        player [[ level.perk_bought_func ]]( perk );
    }
    player.perk_purchased = undefined;
    if (is_false(player.power_on))
    {
        wait 1;
        maps\mp\zombies\_zm_perks::perk_pause( player.script_noteworthy );
    }
    bbprint( "zombie_uses", "playername %s playerscore %d round %d name %s x %f y %f z %f type %s", player.name, player.score, level.round_number, perk, player.origin, "perk" );
	player setblur( 4, 0.1 );
	wait 0.1;
	player setblur( 0, 0.1 );
    player thread [[level._custom_cperks[cperk_id].cperk_give_perk]]();
}

default_vending_think( cperk_id )
{
    level endon("end_game");
    level endon( cperk_id + "_off" );
    //printf("default_vending_think" + cperk_id);
    while( true )
    {
        self waittill("trigger", player);
        player IPrintLn("trigger");
        if(!has_cperk(player, cperk_id) && player.score >= level._custom_cperks[cperk_id].cost)
        {
            cperk_add(player, cperk_id);
            player.score = player.score - level._custom_cperks[cperk_id].cost;
            player thread drink_and_give(cperk_id, player, level.machine_assets[cperk_id].bottle);
            self setinvisibletoplayer(player);
        }
        wait 1;
    }
}

trigger_update( cperk_id )
{
    level endon("end_game");
    level endon( "unlimitedsprint_off" );
    while( true )
    {
        foreach(player in level.players) 
        {
            if(has_cperk( player, cperk_id))
                self setinvisibletoplayer( player );
            else
                self setvisibletoplayer( player );
        }
        wait 5;
    }
}

has_cperk(player, cperk_id)
{
    if(!isDefined(player.cperks))
    {
        return 0;
    }
    
    return player.cperks[cperk_id] == 1;
}

cperk_add(player, cperk_id)
{
    if(!isDefined(player.cperks))
    {
        player.cperks = [];
    }
    player.cperks[cperk_id] = 1;
    player notify("update_cperk_ui", cperk_id);
}

cperk_precache()
{
    if(isDefined(level._custom_cperks) && level._custom_cperks.size > 0)
    {
        //printf("zm_cperks.gsc cperk_precache " + level._custom_cperks.size);
        /*a_keys = getarraykeys( level._custom_cperks );
        for(i = 0; i < level._custom_cperks.size; i++)
        {
            //printf("zm_cperks.gsc cperk_precache " + a_keys[i]);
            //level thread [[level._custom_cperks[a_keys[i]].do_precache]]();
        }*/

        foreach(cperks in level._custom_cperks)
        {
            //printf("zm_cperks.gsc cperk_precache " + cperks.alias);
            level [[cperks.do_precache]]();
        }
    }
    waittillframeend;
}
cperk_think()
{
    if(isDefined(level._custom_cperks) && level._custom_cperks.size > 0)
    {
        //printf("zm_cperks.gsc cperk_think " + level._custom_cperks.size);
        /*a_keys = getarraykeys( level._custom_cperks );
        for(i = 0; i < level._custom_cperks.size; i++)
        {
            //printf("zm_cperks.gsc cperk_think " + a_keys[i]);
            //[[level._custom_cperks[a_keys[i]].cperk_setup]]();
            //level thread [[level._custom_cperks[a_keys[i]].cperk_think]]();
            waittillframeend;
        }*/

        foreach(cperks in level._custom_cperks)
        {
            //printf("zm_cperks.gsc cperk_think " + cperks.alias);
            level [[cperks.cperk_setup]]();
            level thread [[cperks.cperk_think]]();
        }
    }
    waittillframeend;
}
add_cperk_machine(cperk_id, origin, angles)
{
    if(!isDefined(level._custom_cperks[cperk_id].machine))
    {
        level._custom_cperks[cperk_id].machine = [];
    }
    //printf("add_cperk_machine level._custom_cperks[cperk_id].machine "  + level._custom_cperks[cperk_id].machine.size);
    size = level._custom_cperks[cperk_id].machine.size;
    if(size < 0)
    {
        size = 0;
    }
    machine = spawn( "script_model", origin);
    machine.angles = angles;
    machine.collision = spawn("script_model", origin);
    machine.collision setModel( "zm_collision_perks1" );
    machine.collision.angles = angles;
    //printf("add_cperk_machine machine");

    level._custom_cperks[cperk_id].machine[size] = machine;

    if(!isDefined(level._custom_cperks[cperk_id].machine_triggers))
    {
        level._custom_cperks[cperk_id].machine_triggers = [];
    }
    //printf("add_cperk_machine level._custom_cperks[cperk_id].machine_triggers "  + level._custom_cperks[cperk_id].machine_triggers.size);

    trigger = spawn( "trigger_radius_use", origin+(0,0,70), 0, 72, 64 );
    trigger usetriggerrequirelookat();
    trigger sethintstring( "default hint string" );
    trigger setcursorhint( "HINT_NOICON" );
    trigger triggerignoreteam();
    //printf("add_cperk_machine trigger");
    size = level._custom_cperks[cperk_id].machine_triggers.size;
    level._custom_cperks[cperk_id].machine_triggers[size] = trigger;
    //printf("add_cperk_machine");
}

register_cperk_callback_on_actor_damage( cperk_id, callback_on_actor_damage_func )
{
    level._custom_cperks[cperk_id].callback_on_actor_damage_func = callback_on_actor_damage_func;
}

register_cperk_machine(cperk_id, cperk_setup_func, cperk_think_func)
{
    level._custom_cperks[cperk_id].cperk_setup = cperk_setup_func;
    level._custom_cperks[cperk_id].cperk_think = cperk_think_func;
}

register_cperk_trigger_think(cperk_id, cperk_trigger_think_func, cperk_give_perk_func)
{
    if(!isDefined(cperk_trigger_think_func))
    {
        cperk_trigger_think_func = ::default_vending_think;
    }
    level._custom_cperks[cperk_id].cperk_trigger_think_func = cperk_trigger_think_func;
    if(!isDefined(cperk_give_perk_func))
    {
        cperk_give_perk_func = ::default_give_perk;
    }
    level._custom_cperks[cperk_id].cperk_give_perk_func = cperk_give_perk_func;
}

register_cperk_callback_on_perk_lost(cperk_id, on_perk_lost_func)
{
    level._custom_cperks[cperk_id].on_perk_lost_func = on_perk_lost_func;
}

register_cperk_precache_func(cperk_id, cperk_func)
{
    level._custom_cperks[cperk_id].do_precache = cperk_func;
}

register_cperk_basic_info(cperk_id, cperk_alias, cperk_cost, cperk_bottle)
{
    if(!isDefined(level._custom_cperks))
    {
        level._custom_cperks = [];
    }
    level._custom_cperks[cperk_id] = SpawnStruct();
    level._custom_cperks[cperk_id].alias = cperk_alias;
    level._custom_cperks[cperk_id].cost = cperk_cost;
    level._custom_cperks[cperk_id].hint_string = "Hold ^3[{+activate}] ^7for " + cperk_alias + " [Cost: " + cperk_cost + "]";
    level._custom_cperks[cperk_id].perk_bottle = cperk_bottle;
    //printf("register_cperk_basic_info");
}
