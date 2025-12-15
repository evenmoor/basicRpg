extends Node
#global wrapper for player stats

#health values
var max_health:int = 35
var health:int = max_health
var health_recovery = 5

#combat values
var weapon_hit_rate:float = .85
var weapon_damage_min:int = 5
var weapon_damage_max:int = 10
var shield_damage_reduction:float = .5
