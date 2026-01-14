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
const level_cap = 99
var current_level = 1
var current_exp = 0
var exp_for_next_level = 0

func _getRequiredExp(level)-> int:
	return round(pow(level, 1.8) + level * 4)

func levelUp()-> void:
	if(current_exp >= exp_for_next_level) and (current_level < level_cap): #double check the level up is valid
		current_level += 1
		current_exp = current_exp - exp_for_next_level
		exp_for_next_level = _getRequiredExp(current_level)
	
		max_health += 15
		health_recovery += 2
		weapon_damage_min += 1
		weapon_damage_max += 2
		
		if(current_level % 20 == 0):
			shield_damage_reduction += .1

func _ready() -> void:
	exp_for_next_level = _getRequiredExp(current_level + 1)
