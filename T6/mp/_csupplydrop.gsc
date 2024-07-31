#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\_utility;

/*
    Mod: Custom supply drop
    Developed by DoktorSAS
    Special credit to Cooljay
*/

/**
 * Exemple on how to spawns a supply drop by calling the summon_supply_airdrop function. 
 */
spawnSupplyDrop()
{
    thread summon_supply_airdrop(self.origin, ::testonuse);
}

/**
 * Obtain a random player location to use as a drop location
 * @param {vector} store_location - If defined it will allow to store all the generate locations.
 * @return {vector} airdrop_location - The obtain location origin.
 */
player_based_drop_location( store_location )
{
    if(!isDefined(level.airdrop_locations) && isDefined(store_location))
    {
        level.airdrop_locations = [];
    }
    airdrop_location = undefined;
    while(!isDefined(airdrop_location))
    {
        player = level.players[RandomIntRange(0, level.players.size)];
        if(IsAlive(player) && player IsOnGround())
        {
            airdrop_location = player.origin;
        }
    }

    if(isDefined(store_location))
    {
        level.airdrop_locations[level.airdrop_locations.size] = airdrop_location;
    }
    return airdrop_location;
}

/**
 * Summons a supply drop helicopter to a specified location.
 * @param {vector} drop_location_origin - The origin point where the supply drop will be deployed.
 * @param {string} team - The team to which the supply drop is assigned (default is "any").
 * @param {function} oncaptured - The function to call when the supply drop is captured.
 * @return {struct} crate - The created supply drop crate.
 */
summon_supply_airdrop(drop_location_origin, oncaptured, team)
{
	if(!isDefined(team))
	{
		team = "any";
	}
	crate = SpawnStruct();
	helicoptertarget = drop_location_origin + (0, 0, 1500);
    helicopterspawn = level.mapcenter + (10000, 10000, helicoptertarget[2]);
    helicopterleave = level.mapcenter + (-10000, -10000, helicoptertarget[2]);

    crate.supplydrop = spawn_entity("script_model", "t6_wpn_drop_box", helicopterspawn + (0, 0, -70), VectorToAngles(helicoptertarget - helicopterspawn));
	chopper = spawn_helicopter(self, helicopterspawn, team, VectorToAngles(helicoptertarget - helicopterspawn), "heli_supplydrop_mp", "veh_t6_drone_supply", crate.supplydrop);
	chopper SetVehGoalPos(helicoptertarget, 0);

	while (Distance(chopper.origin, helicoptertarget) > 7500)
        wait 0.05;

	supplydropspeed = getdvarintdefault("scr_supplydropSpeedStarting", 125);
    supplydropaccel = getdvarintdefault("scr_supplydropAccelStarting", 100);
    chopper setspeed(int(supplydropspeed / 8), int(supplydropaccel / 4));
    chopper waittill("goal");
	wait 2;
    crate.supplydrop Unlink();
	crate.collision = SpawnCollision("collision_clip_32x32x32", "collider", crate.supplydrop.origin, crate.supplydrop.angles);
    crate.supplydrop thread physics_await_stationary(crate.collision);
	supplydropspeed = getdvarintdefault("scr_supplydropSpeedStarting", 125);
    supplydropaccel = getdvarintdefault("scr_supplydropAccelStarting", 100);
    chopper setspeed(supplydropspeed, supplydropaccel);
	chopper SetVehGoalPos(helicopterleave, 0);
    wait 5;
	chopper waittill("goal");
    chopper delete();

	crate.supplydrop.visibletoall = 1;
	crate.supplydrop setteam("any");
	crate.supplydrop.curprogress = 0;
    crate.supplydrop.inuse = 0;
    crate.supplydrop.userate = 1;
    crate.supplydrop.usetime = 3;
	crate.supplydrop.oncaptured = oncaptured;
    crate.supplydrop.owner = crate.supplydrop;

	crate.supplydrop thread maps\mp\killstreaks\_supplydrop::crateactivate(undefined);
	crate.supplydrop thread crateusethink();
	crate thread crate_destroy();
	return crate;
}

/**
 * Handles the destruction of the supply drop crate.
 */
crate_destroy()
{
	self endon("death");
    self.supplydrop waittill_any("death", "captured");
	self.supplydrop thread maps\mp\killstreaks\_supplydrop::cratedeactivate();
    self.supplydrop delete();
	self.collision delete();
}

/**
 * A test function that prints "testonuse" when called.
 */
testonuse()
{
	self IPrintLn("testonuse");
}

/**
 * Monitors and handles the usage of the supply drop crate.
 */
crateusethink()
{
    while (isdefined(self))
    {
        self waittill("trigger", player);

        if (!isalive(player))
            continue;

        if (!player isonground())
            continue;

        useent = self spawnuseent();
        result = 0;

        self.useent = useent;
		usetime = self.usetime;
		if(level.teambased) 
		{
			if(isDefined(self.usetime_axis) && player.team == "axis")
			{
				usetime = self.usetime_axis;
			}
			else if(isDefined(self.usetime_allies) && player.team == "axis")
			{
				usetime = self.usetime_allies;
			}
		}
        result = useent useholdthink(player, float(self.usetime * 1000));

        if (isdefined(useent))
            useent delete();

        if (result)
        {
            self notify("captured", player, 0);
			player [[self.oncaptured]]();
			self.useent delete();
        }
    }
}

/**
 * Waits for the crate to become stationary after being dropped.
 * @param {entity} collision - The collision entity associated with the crate.
 */
physics_await_stationary(collision)
{
	if(isDefined(collision))
	{
		collision LinkTo(self);
	}
	forcepoint = self.origin;
    initialvelocity = (0, 0, 0);
    self physicslaunch(forcepoint, initialvelocity);
    self waittill("stationary");
}

/**
 * Spawns an entity with a specified class, model, origin, and angles.
 * @param {string} class - The class of the entity to spawn.
 * @param {string} model - The model to assign to the entity.
 * @param {vector} origin - The origin point of the entity.
 * @param {vector} angles - The angles of the entity.
 * @return {entity} entity - The spawned entity.
 */
spawn_entity(class, model, origin, angles)
{
    entity = Spawn(class, origin);
    
    if (IsDefined(angles))
        entity.angles = angles;
    if (IsDefined(model))
        entity SetModel(model);
        
    entity.custom = true;
    
    return entity;
}

/**
 * Spawns a helicopter with the specified parameters.
 * @param {entity} owner - The owner of the helicopter.
 * @param {vector} origin - The origin point of the helicopter.
 * @param {string} team - The team of the helicopter.
 * @param {vector} angles - The angles of the helicopter.
 * @param {string} model - The model of the helicopter.
 * @param {string} targetname - The target name of the helicopter.
 * @param {entity} entity - The entity associated with the helicopter.
 * @return {entity} chopper - The spawned helicopter.
 */
spawn_helicopter(owner, origin, team, angles, model, targetname, entity) 
{
	chopper = spawnhelicopter(owner, origin, angles, model, targetname);
	if(isDefined(entity))
	{
		entity linkto(chopper);
	}
    chopper.owner = owner;
    chopper.maxhealth = 1500;
    chopper.health = 999999;
    chopper.rocketdamageoneshot = chopper.maxhealth + 1;
    chopper.damagetaken = 0;
    chopper thread maps\mp\killstreaks\_helicopter::heli_damage_monitor("supply_drop_mp");
    chopper.spawntime = gettime();
    supplydropspeed = getdvarintdefault("scr_supplydropSpeedStarting", 125);
    supplydropaccel = getdvarintdefault("scr_supplydropAccelStarting", 100);
    chopper setspeed(supplydropspeed, supplydropaccel);
    maxpitch = getdvarintdefault("scr_supplydropMaxPitch", 25);
    maxroll = getdvarintdefault("scr_supplydropMaxRoll", 45);
    chopper setmaxpitchroll(0, maxroll);
    chopper.team = team;
    chopper setdrawinfrared(1);
    target_set(chopper, vectorscale((0, 0, -1), 25.0));

    chopper thread maps\mp\killstreaks\_supplydrop::helidestroyed();
    return chopper;
}
