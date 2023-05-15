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
    printf("unlimitedsprint.gsc test_cperk.gsc");
    maps\mp\zombies\zm_cperks::register_cperk_basic_info("unlimitedsprint", "Sprint Cola", 2000, "zombie_perk_bottle_jugg");
    maps\mp\zombies\zm_cperks::register_cperk_precache_func("unlimitedsprint", ::unlimitedsprint_precache);
    maps\mp\zombies\zm_cperks::register_cperk_machine("unlimitedsprint", ::unlimitedsprint_perk_machine_setup, ::unlimitedsprint_perk_machine_think); 
    maps\mp\zombies\zm_cperks::register_cperk_trigger_think("unlimitedsprint", ::default_vending_think, ::default_give_perk);
    waittillframeend;

    flag_wait( "initial_blackscreen_passed" );
    flag_wait( "start_zombie_round_logic" );
    wait 1;
    level notify( "unlimitedsprint_on" );   
}

unlimitedsprint_precache()
{
    printf("unlimitedsprint_precache");
    level._effect["unlimitedsprint"] = loadfx( "misc/fx_zombie_cola_jugg_on" );
    level.machine_assets["unlimitedsprint"] = spawnstruct();
    level.machine_assets["unlimitedsprint"].weapon = "zombie_perk_bottle_jugg";
    level.machine_assets["unlimitedsprint"].off_model = level.machine_assets[ "juggernog" ].off_model;
    level.machine_assets["unlimitedsprint"].on_model = level.machine_assets[ "juggernog" ].on_model;
    //level.machine_assets["unlimitedsprint"].power_on_callback = ::custom_vending_power_on;
    //level.machine_assets["unlimitedsprint"].power_off_callback = ::custom_vending_power_off;
}

unlimitedsprint_register_clientfield()
{
    printf("unlimitedsprint_register_clientfield");
}

unlimitedsprint_set_clientfield()
{
    printf("unlimitedsprint_set_clientfield");
}


unlimitedsprint_watch_for_emp()
{
    self endon("unlimitedsprint_off");
    while ( true )
    {
        level waittill( "emp_detonate", origin, radius );

        if ( distancesquared( origin, self.origin ) < radius * radius )
        {
            //playfx( level._effect["powerup_off"], self.origin );
            level notify( "unlimitedsprint_off" );
            break;
        }

    }
    wait level.zombie_vars["emp_perk_off_time"];
    level notify( "unlimitedsprint_on" );
}

unlimitedsprint_perk_machine_setup()
{
    printf("unlimitedsprint_perk_machine_setup");
    add_cperk_machine("unlimitedsprint", (2002, 718, -55), ( 0, -128, 0 ));
}

unlimitedsprint_perk_machine_think( cperk_id )
{
    printf("unlimitedsprint_perk_machine_think");
    waittillframeend;
    while(true)
    {
        machine = level._custom_cperks["unlimitedsprint"].machine;
        machine_triggers = level._custom_cperks["unlimitedsprint"].machine_triggers;

        for ( i = 0; i < machine.size; i++ )
        {
            machine[i] setmodel( level.machine_assets["unlimitedsprint"].off_model );
        }

        for ( i = 0; i < machine_triggers.size; i++ )
        {
            machine_triggers[i] sethintstring("You must turn on the Power first");
        }
        
        level thread maps\mp\zombies\_zm_perks::do_initial_power_off_callback( machine, "unlimitedsprint" );
        array_thread( machine_triggers, ::set_power_on, 0 );

        level waittill( "unlimitedsprint_on" );

        for ( i = 0; i < machine.size; i++ )
        {
            machine[i] setmodel( level.machine_assets["unlimitedsprint"].on_model );
            machine[i].effect playsound( "zmb_perks_power_on" );
            machine[i].effect vibrate( vectorscale( ( 0, -1, 0 ), 100.0 ), 0.3, 0.4, 3 );
            machine[i].effect = spawn( "script_model", machine[i].origin);
            machine[i].effect.angles = machine[i].angles;
            machine[i].effect setmodel( level.machine_assets["unlimitedsprint"].off_model );
            machine[i].effect thread perk_fx( "jugger_light" );
            machine[i].effect thread play_loop_on_machine();
        }

        level notify( "unlimitedsprint_power_on" );
        array_thread( machine_triggers, ::set_power_on, 1 );
         for ( i = 0; i < machine_triggers.size; i++ )
        {
            machine_triggers[i] sethintstring( level._custom_cperks["unlimitedsprint"].hint_string );
            machine_triggers[i] thread [[level._custom_cperks["unlimitedsprint"].cperk_trigger_think]]( "unlimitedsprint" );
        }
        array_thread( machine, ::unlimitedsprint_watch_for_emp);

        if ( isdefined( level.machine_assets["unlimitedsprint"].power_on_callback ) )
            array_thread( machine, level.machine_assets["unlimitedsprint"].power_on_callback );

        level waittill( "unlimitedsprint_off" );


        if ( isdefined( level.machine_assets["unlimitedsprint"].power_off_callback ) )
            array_thread( machine, level.machine_assets["unlimitedsprint"].power_off_callback );

        array_thread( machine, maps\mp\zombies\zm_cperks::turn_cperk_off );
    }
}

//register_perk_host_migration_func
unlimitedsprint_host_migration_func()
{
    
}
