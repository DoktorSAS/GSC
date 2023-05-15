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


main()
{
    printf("zm_cperks.gsc");
    flag_wait( "initial_blackscreen_passed" );
    cperk_precache();
    cperk_think();
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

default_vending_think( cperk_id )
{
    level endon("end_game");
    level endon( "unlimitedsprint_off" );
    while( true )
    {
        self waittill("trigger", player);
        if(!has_cperk(player, cperk_id) && player.score >= level._custom_cperks[cperk_id].cost)
        {
            cperk_add(player, cperk_id);
            player.score = player.score - level._custom_cperks[cperk_id].cost;
            player thread [[level._custom_cperks[cperk_id].cperk_give_perk]]();
            self SetInvisibleToPlayer(player);
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
}

cperk_precache()
{
    if(isDefined(level._custom_cperks) && level._custom_cperks.size > 0)
    {
        printf("zm_cperks.gsc cperk_precache " + level._custom_cperks.size);
        /*a_keys = getarraykeys( level._custom_cperks );
        for(i = 0; i < level._custom_cperks.size; i++)
        {
            printf("zm_cperks.gsc cperk_precache " + a_keys[i]);
            //level thread [[level._custom_cperks[a_keys[i]].do_precache]]();
        }*/

        foreach(cperks in level._custom_cperks)
        {
            printf("zm_cperks.gsc cperk_precache " + cperks.alias);
            level [[cperks.do_precache]]();
        }
    }
    waittillframeend;
}
cperk_think()
{
    if(isDefined(level._custom_cperks) && level._custom_cperks.size > 0)
    {
        printf("zm_cperks.gsc cperk_think " + level._custom_cperks.size);
        /*a_keys = getarraykeys( level._custom_cperks );
        for(i = 0; i < level._custom_cperks.size; i++)
        {
            printf("zm_cperks.gsc cperk_think " + a_keys[i]);
            //[[level._custom_cperks[a_keys[i]].cperk_setup]]();
            //level thread [[level._custom_cperks[a_keys[i]].cperk_think]]();
            waittillframeend;
        }*/

        foreach(cperks in level._custom_cperks)
        {
            printf("zm_cperks.gsc cperk_think " + cperks.alias);
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
    printf("add_cperk_machine level._custom_cperks[cperk_id].machine "  + level._custom_cperks[cperk_id].machine.size);
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
    printf("add_cperk_machine machine");

    level._custom_cperks[cperk_id].machine[size] = machine;

    if(!isDefined(level._custom_cperks[cperk_id].machine_triggers))
    {
        level._custom_cperks[cperk_id].machine_triggers = [];
    }
    printf("add_cperk_machine level._custom_cperks[cperk_id].machine_triggers "  + level._custom_cperks[cperk_id].machine_triggers.size);

    trigger = spawn( "trigger_radius_use", origin+(0,0,70), 0, 72, 64 );
    trigger usetriggerrequirelookat();
    trigger sethintstring( "default hint string" );
    trigger setcursorhint( "HINT_NOICON" );
    trigger triggerignoreteam();
    printf("add_cperk_machine trigger");
    size = level._custom_cperks[cperk_id].machine_triggers.size;
    level._custom_cperks[cperk_id].machine_triggers[size] = trigger;

    printf("add_cperk_machine");
}

register_cperk_machine(cperk_id, cperk_setup_func, cperk_think_func)
{
    level._custom_cperks[cperk_id].cperk_setup = cperk_setup_func;
    level._custom_cperks[cperk_id].cperk_think = cperk_think_func;
}

register_cperk_trigger_think(cperk_id, cperk_trigger_think, cperk_give_perk)
{
    level._custom_cperks[cperk_id].cperk_trigger_think = cperk_trigger_think;
    level._custom_cperks[cperk_id].cperk_give_perk = cperk_give_perk;
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
    printf("register_cperk_basic_info");
}
