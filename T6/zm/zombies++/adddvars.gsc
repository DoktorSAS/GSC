#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/zombies/_zm;
#include maps/mp/zombies/_zm_utility;

/*
  Mod: zombies++ config vars
  
  The mod its not been developed by me i just extracted the code that add the new dvars 
  and implemented a patch for default values.
  
  Original: https://github.com/Paintball/BO2-GSC-Releases/tree/master
*/
init()
{
	level thread onPlayerConnect();
}

_getDvarIntDefault( dvar, value )
{
	if(getDvar(dvar) == "")
	{
		setDvar(dvar, value);
	}
	return getDvarInt(dvar);
}

_getDvarFloatDefault( dvar, value )
{
	if(getDvar(dvar) == "")
	{
		setDvar(dvar, value);
	}
	return getDvarFloat(dvar);
}

init_serversinfo() // credits to JezuzLizard!!! This is a huge help in making this happen
{
	level.player_starting_points = _getDvarIntDefault("playerStartingPoints", 500);
	// sets the perk limit for all players
	level.perk_purchase_limit = _getDvarIntDefault("perkLimit", 4);
	// sets the maximum number of zombies that can be on the map at once 32 max
	level.zombie_ai_limit = _getDvarIntDefault("zombieAiLimit", 24);
	// sets the number of zombie bodies that can be on the map at once
	level.zombie_actor_limit = _getDvarIntDefault("zombieActorLimit", 32);
	// enables midround hellhounds WARNING: causes permanent round pauses on maps that aren't bus depot, town or farm
	level.mixed_rounds_enabled = _getDvarIntDefault("midroundDogs", 0);
	// disables the end game check WARNING: make sure to include a spectator respawner and auto revive function
	level.no_end_game_check = _getDvarIntDefault("noEndGameCheck", 0);
	if ( level.mixed_rounds_enabled )
	{
		if ( level.script != "zm_transit" || is_classic() || level.scr_zm_ui_gametype == "zgrief" )
		{
			level.mixed_rounds_enabled = 0;
		}
	}

	// sets the solo laststand pistol
	level.default_solo_laststandpistol = getDvar("soloLaststandWeapon");
	if ( level.default_solo_laststandpistol == "" || level.default_solo_laststandpistol == "m1911_upgraded_zm" )
	{
		level.default_solo_laststandpistol = "m1911_upgraded_zm";
		if ( level.script == "zm_tomb" )
		{
			level.default_solo_laststandpistol = "c96_upgraded_zm";
		}
	}
	// the default laststand pistol
	level.default_laststandpistol = getDvar("coopLaststandWeapon");
	if ( level.default_laststandpistol == "" || level.default_laststandpistol == "m1911_zm" )
	{
		level.default_laststandpistol = "m1911_zm";
		if ( level.script == "zm_tomb" )
		{
			level.default_laststandpistol = "c96_zm";
		}
	}

	// set the starting weapon
	level.start_weapon = getDvar("startWeaponZm");

	if ( level.start_weapon == "" || level.start_weapon== "m1911_zm" )
	{
		level.start_weapon = "m1911_zm";
		if ( level.script == "zm_tomb" )
		{
			level.start_weapon = "c96_zm";
		}
	}

	// sets all zombies to this speed lower values result in walkers higher values sprinters
	level.zombie_move_speed = _getDvarIntDefault("zombieMoveSpeed", 1);
	// locks the zombie movespeed to the above value
	level.zombieMoveSpeedLocked = _getDvarIntDefault("zombieMoveSpeedLocked", 0);
	// sets whether there is a cap to the zombie movespeed active
	level.zombieMoveSpeedCap = _getDvarIntDefault("zombieMoveSpeedCap", 0);
	// sets the value to the zombie movespeed cap
	level.zombieMoveSpeedCapValue = _getDvarIntDefault("zombieMoveSpeedCapValue", 1);
	// sets the round number any value between 1-255
	level.round_number = _getDvarIntDefault("roundNumber", 1);
	// enables the override for zombies per round
	level.overrideZombieTotalPermanently = _getDvarIntDefault("overrideZombieTotalPermanently", 0);
	// sets the number of zombies per round to the value indicated
	level.overrideZombieTotalPermanentlyValue = _getDvarIntDefault("overrideZombieTotalPermanentlyValue", 6);
	// enables the override for zombie health
	level.overrideZombieHealthPermanently = _getDvarIntDefault("overrideZombieHealthPermanently", 0);
	// sets the health of zombies every round to the value indicated
	level.overrideZombieHealthPermanentlyValue = _getDvarIntDefault("overrideZombieHealthPermanentlyValue", 150);
	// enables the health cap override so zombies health won't grow beyond the value indicated
	level.overrideZombieMaxHealth = _getDvarIntDefault("overrideZombieMaxHealth", 0);
	// sets the maximum health zombie health will increase to
	level.overrideZombieMaxHealthValue = _getDvarIntDefault("overrideZombieMaxHealthValue", 150);

	// disables walkers
	level.disableWalkers = _getDvarIntDefault("disableWalkers", 0);
	if (level.disableWalkers)
	{
		level.speed_change_round = undefined;
	}
	// set afterlives on mob to 1 like a normal coop match and sets the prices of doors on origins to be higher
	level.disableSoloMode = _getDvarIntDefault("disableSoloMode", 0);
	if (level.disableSoloMode)
	{
		level.is_forever_solo_game = undefined;
	}
	// disables all drops
	level.zmPowerupsNoPowerupDrops = _getDvarIntDefault("zmPowerupsNoPowerupDrops", 0);

	// Zombie_Vars:
	// The reason zombie_vars are first set to a var is because they don't reliably set when set directly to the value of a dvar
	// sets the maximum number of drops per round
	level.zombie_vars["zombie_powerup_drop_max_per_round"] = _getDvarIntDefault("maxPowerupsPerRound", 4);
	// sets the powerup drop rate lower is better
	level.zombie_vars["zombie_powerup_drop_increment"] = _getDvarIntDefault("powerupDropRate", 2000);
	// makes every zombie drop a powerup
	level.zombie_vars["zombie_drop_item"] = _getDvarIntDefault("zombiesAlwaysDropPowerups", 0);
	// increase these below vars to increase drop rate
	// points to the powerup increment to a powerup drop related to level.zombie_vars["zombie_powerup_drop_increment"]
	level.zombie_vars["zombie_score_kill_4p_team"] = _getDvarIntDefault("fourPlayerPowerupScore", 50);
	// points to the powerup increment to a powerup drop related to level.zombie_vars["zombie_powerup_drop_increment"]
	level.zombie_vars["zombie_score_kill_3p_team"] = _getDvarIntDefault("threePlayerPowerupScore", 50);
	// points to the powerup increment to a powerup drop related to level.zombie_vars["zombie_powerup_drop_increment"]
	level.zombie_vars["zombie_score_kill_2p_team"] = _getDvarIntDefault("twoPlayerPowerupScore", 50);
	// points to the powerup increment to a powerup drop related to level.zombie_vars["zombie_powerup_drop_increment"]
	level.zombie_vars["zombie_score_kill_1p_team"] = _getDvarIntDefault("onePlayerPowerupScore", 50);
	// points for melee kills to the powerup increment to a powerup drop
	level.zombie_vars["zombie_score_bonus_melee"] = _getDvarIntDefault("powerupScoreMeleeKill", 80);
	// points for headshot kills to the powerup increment to a powerup drop
	level.zombie_vars["zombie_score_bonus_head"] = _getDvarIntDefault("powerupScoreHeadshotKill", 50);
	// points for neck kills to the powerup increment to a powerup drop
	level.zombie_vars["zombie_score_bonus_neck"] = _getDvarIntDefault("powerupScoreNeckKill", 20);
	// points for torso kills to the powerup increment to a powerup drop
	level.zombie_vars["zombie_score_bonus_torso"] = _getDvarIntDefault("powerupScoreTorsoKill", 10);
	// sets the zombie spawnrate; max is 0.08
	level.zombie_vars["zombie_spawn_delay"] = _getDvarFloatDefault("zombieSpawnRate", 2);
	// sets the zombie spawnrate multiplier increase
	level.zombieSpawnRateMultiplier = _getDvarFloatDefault("zombieSpawnRateMultiplier", 0.95);
	// locks the spawnrate so it does not change throughout gameplay
	level.zombieSpawnRateLocked = _getDvarIntDefault("zombieSpawnRateLocked", 0);
	// alters the number of zombies per round formula amount of zombies per round is roughly correlated to this value
	// ie half as many zombies per player is half as many zombies per round
	level.zombie_vars["zombie_ai_per_player"] = _getDvarIntDefault("zombiesPerPlayer", 6);
	// sets the flat amount of hp the zombies gain per round not used after round 10
	level.zombie_vars["zombie_health_increase"] = _getDvarIntDefault("zombieHealthIncreaseFlat", 100);
	// multiplies zombie health by this value every round after round 10
	level.zombie_vars["zombie_health_increase_multiplier"] = _getDvarFloatDefault("zombieHealthIncreaseMultiplier", 0.1);
	// base zombie health before any multipliers or additions
	level.zombieHealthStart = _getDvarIntDefault("zombieHealthStart", 150);
	level.zombie_vars["zombie_health_start"] = level.zombieHealthStart;
	// time before new runners spawn on early rounds
	level.zombie_vars["zombie_new_runner_interval"] = _getDvarIntDefault("zombieNewRunnerInterval", 10);
	// determines level.zombie_move_speed on original
	level.zombie_vars["zombie_move_speed_multiplier"] = _getDvarIntDefault("zombieMoveSpeedMultiplier", 10);
	// determines level.zombie_move_speed on easy
	level.zombie_vars["zombie_move_speed_multiplier_easy"] = _getDvarIntDefault("zombieMoveSpeedMultiplierEasy", 8);
	// affects the number of zombies per round formula
	level.zombie_vars["zombie_max_ai"] = _getDvarIntDefault("zombieMaxAi", 24);
	// affects the check for zombies that have fallen thru the map
	level.zombie_vars["below_world_check"] = _getDvarIntDefault("belowWorldCheck", -1000);
	// sets whether spectators respawn at the end of the round
	level.zombie_vars["spectators_respawn"] = _getDvarIntDefault("customSpectatorsRespawn", 1);
	// sets the time that the game takes during the end game intermission
	level.zombie_vars["zombie_intermission_time"] = _getDvarIntDefault("zombieIntermissionTime", 20);
	// the time between rounds
	level.zombie_vars["zombie_between_round_time"] = _getDvarIntDefault("zombieBetweenRoundTime", 15);
	// time before the game starts
	level.zombie_vars["game_start_delay"] = _getDvarIntDefault("roundStartDelay", 0);
	// points all players lose when a player bleeds out %10 default
	level.zombie_vars["penalty_no_revive"] = _getDvarFloatDefault("bleedoutPointsLostAllPlayers", 0.1);
	// penalty to the player who died 10% of points by default
	level.zombie_vars["penalty_died"] = _getDvarFloatDefault("bleedoutPointsLostSelf", 0.1);
	// points players lose on down %5 by default
	level.zombie_vars["penalty_downed"] = _getDvarFloatDefault("downedPointsLostSelf", 0.05);
	// unknown
	level.zombie_vars["starting_lives"] = _getDvarIntDefault("playerStartingLives", 1);
	// points earned per zombie kill in a 4 player game
	level.zombie_vars["zombie_score_kill_4player"] = level.zombie_vars["zombie_score_kill_4player"];
	// points earned per zombie kill in a 3 player game
	level.zombie_vars["zombie_score_kill_3player"] = _getDvarIntDefault("threePlayerScorePerZombieKill", 50);
	level.zombie_vars["zombie_score_kill_3player"] = level.zombie_vars["zombie_score_kill_3player"];
	// points earned per zombie kill in a 2 player game
	level.zombie_vars["zombie_score_kill_2player"] = _getDvarIntDefault("twoPlayerScorePerZombieKill", 50);
	// points earned per zombie kill in a 1 player game
	level.zombie_vars["zombie_score_kill_1player"] = _getDvarIntDefault("onePlayerScorePerZombieKill", 50);
	// points given for a normal attack
	level.zombie_vars["zombie_score_damage_normal"] = _getDvarIntDefault("pointsPerNormalAttack", 10);
	// points given for a light attack
	level.zombie_vars["zombie_score_damage_light"] = _getDvarIntDefault("pointsPerLightAttack", 10);
	// players turn into a zombie on death WARNING: buggy as can be and is missing assets
	level.zombie_vars["zombify_player"] = _getDvarIntDefault("shouldZombifyPlayer", 0);
	// points scalar for allies team
	level.zombie_vars["allies"]["zombie_point_scalar"] = _getDvarIntDefault("alliesPointsMultiplier", 1);
	// points scalar for axis team
	level.zombie_vars["axis"]["zombie_point_scalar"] = _getDvarIntDefault("axisPointsMultiplier", 1);
	// sets the radius of emps explosion lower this to 1 to render emps useless
	level.zombie_vars["emp_perk_off_range"] = _getDvarIntDefault("empPerkExplosionRadius", 420);
	// sets the duration of emps on perks set to 0 for infiinite emps
	level.zombie_vars["emp_perk_off_time"] = _getDvarIntDefault("empPerkOffDuration", 90);
	// riotshield health
	level.zombie_vars["riotshield_hit_points"] = _getDvarIntDefault("riotshieldHitPoints", 2250);
	// jugg health bonus
	level.zombie_vars["zombie_perk_juggernaut_health"] = _getDvarIntDefault("juggHealthBonus", 160);
	// perma jugg health bonus
	level.zombie_vars["zombie_perk_juggernaut_health_upgrade"] = _getDvarIntDefault("permaJuggHealthBonus", 190);
	// phd min explosion damage
	level.zombie_vars["minPhdExplosionDamage"] = _getDvarIntDefault("minPhdExplosionDamage", 1000);
	// phd max explosion damage
	level.zombie_vars["maxPhdExplosionDamage"] = _getDvarIntDefault("maxPhdExplosionDamage", 5000);
	// phd explosion radius
	level.zombie_vars["phdDamageRadius"] = _getDvarIntDefault("phdDamageRadius", 300);
	// zombie counter onscreen
	level.zombie_vars["enableZombieCounter"] = _getDvarIntDefault("enableZombieCounter", 1);
	// change mystery box price
	level.zombie_vars["customMysteryBoxPriceEnabled"] = _getDvarIntDefault("customMysteryBoxPriceEnabled", 0);
	// set mystery box price
	level.zombie_vars["customMysteryBoxPriceEnabled"] = _getDvarIntDefault("customMysteryBoxPrice", 500);
	// disable custom perks
	level.zombie_vars["disableAllCustomPerks"] = _getDvarIntDefault("disableAllCustomPerks", 0);
	// enable custom phdflopper
	level.zombie_vars["enablePHDFlopper"] = _getDvarIntDefault("enablePHDFlopper", 1);
	// enable custom staminup
	level.zombie_vars["enableStaminUp"] = _getDvarIntDefault("enableStaminUp", 1);
	// enable custom deadshot
	level.zombie_vars["enableDeadshot"] = _getDvarIntDefault("enableDeadshot", 1);
	// enable custom mule kick
	level.zombie_vars["enableMuleKick"] = _getDvarIntDefault("enableMuleKick", 1);
}
