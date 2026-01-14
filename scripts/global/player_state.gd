extends Node
#global wrapper for player stats

#respawn position for when the player dies the tutorial puts it here but it should probably be set based on the world map locations
const initial_position:Vector2 = Vector2(736, 550)
var last_position:Vector2 = initial_position

#health values
var max_health:int = 35
var health:int = max_health
var health_recovery = 5

#combat values
var weapon_hit_rate:float = .85
var weapon_damage_min:int = 5
var weapon_damage_max:int = 10
var shield_damage_reduction:float = .5

#experience values
var current_level = 1
var current_exp = 0
var exp_for_next_level = 30
