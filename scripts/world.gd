extends Node2D

@export var player_health_bar:ProgressBar
@onready var player:CharacterBody2D = $player

func updateUI() -> void:
	#load values from the global PlayerState script
	player_health_bar.max_value = PlayerState.max_health
	player_health_bar.value = PlayerState.health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	updateUI()
	player.position = PlayerState.last_position
	
#func _process(_delta: float) -> void:
	#updateUI()#I don't think this is needed.... unless we do some more health testing
