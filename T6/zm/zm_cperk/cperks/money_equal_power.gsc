#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;

/*
    Mod: test_cperk.gsc
    Developed by @DoktorSAS

    TEMPLATE EXEMPLE OF A CUSTOM PERK
*/

// test_cperk.gsc
init()
{
    printf("money_equal_power.gsc test_cperk.gsc");
    scripts\zm\_zm_cperks::register_cperk_basic_info("money_equal_power", "Money = Power", 2000, "zombie_perk_bottle_jugg");
    scripts\zm\_zm_cperks::register_cperk_precache_func("money_equal_power", ::money_equal_power_precache);
    scripts\zm\_zm_cperks::register_cperk_machine("money_equal_power", ::money_equal_power_perk_machine_setup, ::money_equal_power_perk_machine_think); 
    scripts\zm\_zm_cperks::register_cperk_trigger_think("money_equal_power");
    scripts\zm\_zm_cperks::register_cperk_callback_on_actor_damage( "money_equal_power", ::actor_damage_override_wrapper );
    waittillframeend;

    flag_wait( "initial_blackscreen_passed" );
    flag_wait( "start_zombie_round_logic" );
    wait 1;
    level notify( "money_equal_power_on" );   
}

actor_damage_override_wrapper( inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex )
{
    if(scripts\zm\_zm_cperks::has_cperk( attacker, "money_equal_power") && self.health > 0 && IsAlive(self))
    {
        damage = int(attacker.score/250);
        if(damage > 500)
        {
            damage = 500;
        }
        self finishactordamage( inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex );
    }
}

money_equal_power_precache()
{
    printf("money_equal_power_precache");
    level._effect["money_equal_power"] = loadfx( "misc/fx_zombie_cola_jugg_on" );
    level.machine_assets["money_equal_power"] = spawnstruct();
    level.machine_assets["money_equal_power"].weapon = "zombie_perk_bottle_jugg";
    level.machine_assets["money_equal_power"].bottle = "specialty_armorvest";
    level.machine_assets["money_equal_power"].off_model = level.machine_assets[ "juggernog" ].off_model;
    level.machine_assets["money_equal_power"].on_model = level.machine_assets[ "juggernog" ].on_model;
    //level.machine_assets["money_equal_power"].power_on_callback = ::custom_vending_power_on;
    //level.machine_assets["money_equal_power"].power_off_callback = ::custom_vending_power_off;
}

money_equal_power_register_clientfield()
{
    printf("money_equal_power_register_clientfield");
}

money_equal_power_set_clientfield()
{
    printf("money_equal_power_set_clientfield");
}


money_equal_power_watch_for_emp()
{
    self endon("money_equal_power_off");
    while ( true )
    {
        level waittill( "emp_detonate", origin, radius );

        if ( distancesquared( origin, self.origin ) < radius * radius )
        {
            //playfx( level._effect["powerup_off"], self.origin );
            level notify( "money_equal_power_off" );
            break;
        }

    }
    wait level.zombie_vars["emp_perk_off_time"];
    level notify( "money_equal_power_on" );
}

money_equal_power_perk_machine_setup()
{
    printf("money_equal_power_perk_machine_setup");
    map = getDvar("ui_zm_mapstartlocation");
    switch(map)
    {
        case "town":
            add_cperk_machine("money_equal_power", (2002, 718, -55), ( 0, -128, 0 ));
        break;
    }
    
}

money_equal_power_perk_machine_think( cperk_id )
{
    printf("money_equal_power_perk_machine_think");
    waittillframeend;
    while(true)
    {
        machine = level._custom_cperks["money_equal_power"].machine;
        machine_triggers = level._custom_cperks["money_equal_power"].machine_triggers;

        for ( i = 0; i < machine.size; i++ )
        {
            machine[i] setmodel( level.machine_assets["money_equal_power"].off_model );
        }

        for ( i = 0; i < machine_triggers.size; i++ )
        {
            machine_triggers[i] sethintstring("You must turn on the Power first");
        }
        
        level thread maps\mp\zombies\_zm_perks::do_initial_power_off_callback( machine, "money_equal_power" );
        array_thread( machine_triggers, ::set_power_on, 0 );

        level waittill( "money_equal_power_on" );

        for ( i = 0; i < machine.size; i++ )
        {
            machine[i] setmodel( level.machine_assets["money_equal_power"].on_model );
            machine[i].effect playsound( "zmb_perks_power_on" );
            machine[i].effect vibrate( vectorscale( ( 0, -1, 0 ), 100.0 ), 0.3, 0.4, 3 );
            machine[i].effect = spawn( "script_model", machine[i].origin);
            machine[i].effect.angles = machine[i].angles;
            machine[i].effect setmodel( level.machine_assets["money_equal_power"].off_model );
            machine[i].effect thread perk_fx( "jugger_light" );
            machine[i].effect thread play_loop_on_machine();
        }

        level notify( "money_equal_power_power_on" );
        array_thread( machine_triggers, ::set_power_on, 1 );
        for ( i = 0; i < machine_triggers.size; i++ )
        {
            machine_triggers[i] sethintstring( level._custom_cperks["money_equal_power"].hint_string );
            printf(i + ": trigger thread!");
            machine_triggers[i] thread [[level._custom_cperks["money_equal_power"].cperk_trigger_think_func]]( "money_equal_power" );
        }
        array_thread( machine, ::money_equal_power_watch_for_emp);

        if ( isdefined( level.machine_assets["money_equal_power"].power_on_callback ) )
            array_thread( machine, level.machine_assets["money_equal_power"].power_on_callback );

        level waittill( "money_equal_power_off" );


        if ( isdefined( level.machine_assets["money_equal_power"].power_off_callback ) )
            array_thread( machine, level.machine_assets["money_equal_power"].power_off_callback );

        array_thread( machine, scripts\zm\_zm_cperks::turn_cperk_off );
    }
}

//register_perk_host_migration_func
money_equal_power_host_migration_func()
{
    
}
