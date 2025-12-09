extends Node2D

@export var player_health_bar:ProgressBar

func updateUI() -> void:
	#load values from the global PlayerState script
	player_health_bar.max_value = PlayerState.max_health
	player_health_bar.value = PlayerState.health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	updateUI()

func _process(_delta: float) -> void:
	updateUI()
