extends Control

@export var enemy:Resource = null

#health
var enemy_health:int = 0
var enemy_max_health:int = 0
@onready var enemy_health_bar:ProgressBar = $VBoxContainer/enemyHealthBar
var player_health:int = 0
var player_max_health:int = 0
@onready var player_health_bar:ProgressBar = $"PlayerPanel/PlayerActions/Player Info/playerHealthBar"

func _updateHealthBar(health:int, max_health:int, health_bar:ProgressBar):
	health_bar.value = health
	health_bar.max_value = max_health
	health_bar.get_node("healthBarLabel").text = "HP: " + str(health) + "/" + str(max_health)
	
func _ready() -> void:
	enemy_max_health = enemy.enemy_health
	enemy_health = enemy_max_health
	_updateHealthBar(enemy_health, enemy_max_health, enemy_health_bar)
	
	player_health = PlayerState.health
	player_max_health = PlayerState.max_health
	_updateHealthBar(player_health, player_max_health, player_health_bar)
