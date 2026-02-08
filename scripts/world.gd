extends Node2D

@export var player_health_bar:ProgressBar
@export var player_exp_bar:ProgressBar
@export var player_exp_label:Label
@export var player_weapon_label:Label

@onready var player:CharacterBody2D = $player

#dialogic assets
@onready var dl_character_player = load("res://addons/dialogic/assets/characters/player.dch")
@onready var dl_character_villager = load("res://addons/dialogic/assets/characters/villager1.dch")

func updateUI() -> void:
	#load values from the global PlayerState script
	player_health_bar.max_value = PlayerState.max_health
	player_health_bar.value = PlayerState.health
	
	player_exp_bar.max_value = PlayerState.exp_for_next_level
	player_exp_bar.value = PlayerState.current_exp
	
	var player_level_text = str(PlayerState.current_level)
	if PlayerState.current_level < 10 :
		player_level_text = "0" + player_level_text
	player_exp_label.text = "LVL: " + player_level_text
	
	player_weapon_label.text = "WPN: "+str(PlayerState.weapon_damage_min)+" - "+str(PlayerState.weapon_damage_max)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	updateUI()
	player.position = PlayerState.last_position
	
#func _process(_delta: float) -> void:
	#updateUI()#I don't think this is needed.... unless we do some more health testing


func _on_villager_1_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#print("Villager: Hello!")
		if Dialogic.current_timeline == null: #checks to see if a timeline is running
			var layout = Dialogic.start("villager1") #starts the labeled timeline
			layout.register_character(dl_character_player, $player) #allows tracking of the player sprite for the speech bubble
			layout.register_character(dl_character_villager, $villager1/villagerSprite) 


func _on_villager_1_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("Villager: Goodbye!")
