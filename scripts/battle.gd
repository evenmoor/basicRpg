extends Control

signal textBoxClosed

@export var enemy:Resource = null

#health
var enemy_health:int = 0
var enemy_max_health:int = 0
@onready var enemy_health_bar:ProgressBar = $VBoxContainer/enemyHealthBar
var player_health:int = 0
var player_max_health:int = 0
@onready var player_health_bar:ProgressBar = $"PlayerPanel/PlayerActions/Player Info/playerHealthBar"

#status
var player_is_defending:bool = false

#ui elements
@onready var uiTextArea:TextureRect = $combatTextWraper
@onready var uiCombatText:Label = $combatTextWraper/MarginContainer/combatText
@onready var uiPlayerActions:BoxContainer = $PlayerPanel/PlayerActions

func _updateHealthBar(health:int, max_health:int, health_bar:ProgressBar):
	health_bar.value = health
	health_bar.max_value = max_health
	health_bar.get_node("healthBarLabel").text = "HP: " + str(health) + "/" + str(max_health)
	
#display text in the combat text box
func _displayText(text:String):
	uiCombatText.text = text
	uiTextArea.show()

#check to see the battle is over
func _check_for_victory() -> void:
	print("checking for victory!")

func _enemy_turn() -> void:
	uiPlayerActions.hide()
	_displayText(enemy.enemy_name + " attacks!")
	await self.textBoxClosed 
	
	var hitChance = randf_range(0, 1)
	if(hitChance <= enemy.enemy_hit_rate):
		var damageDealt:int = randi_range(enemy.enemy_min_damage, enemy.enemy_max_damage)
		
		if player_is_defending :
			damageDealt = floori(damageDealt * PlayerState.shield_damage_reduction)
			_displayText("You block, taking " + str(damageDealt) + " damage!")
		else:
			_displayText("You take " + str(damageDealt) + " damage!")
		
		await self.textBoxClosed
		player_health = max(0, player_health - damageDealt) #max usage prevents the player's health from going negative
		_updateHealthBar(player_health, player_max_health, player_health_bar)
	else:
		_displayText("You dodge deftly away from the blow!")
		await self.textBoxClosed
		
	_check_for_victory()
	player_is_defending = false
	uiPlayerActions.show()
#end enemy turn
	
func _on_attack_button_pressed() -> void:
	uiPlayerActions.hide()
	_displayText("You swing at the " + enemy.enemy_name + ".")
	await self.textBoxClosed
	
	var hitChance = randf_range(0, 1)
	if(hitChance <= PlayerState.weapon_hit_rate):
		var damageDealt:int = randi_range(PlayerState.weapon_damage_max, PlayerState.weapon_damage_min)
		_displayText("You hit the " + enemy.enemy_name + " for " + str(damageDealt) + " damage!")
		await self.textBoxClosed
		enemy_health = max(0, enemy_health - damageDealt) #max usage prevents the enemy health from going negative
		_updateHealthBar(enemy_health, enemy_max_health, enemy_health_bar)
	else:
		_displayText("You missed!")
		await self.textBoxClosed
	
	_check_for_victory()
	_enemy_turn()
#end attack button pressed

func _on_defend_button_pressed() -> void:
	uiPlayerActions.hide()
	_displayText("You brace for the hit and recover your strength.")
	await self.textBoxClosed
	
	player_health = min(PlayerState.max_health, player_health + PlayerState.health_recovery) #don't let the player's health go above the maximum
	_updateHealthBar(player_health, player_max_health, player_health_bar)
	player_is_defending = true
	
	#await get_tree().create_timer(0.2).timeout #the tutorial wanted to add this to give a delay. I think it is stupid but figured it could be helpful as an example for future projects
	
	_check_for_victory()
	_enemy_turn()
#end defend button pressed

func _on_run_button_pressed() -> void:
	uiPlayerActions.hide()
	_displayText("You try and run away.")
	await self.textBoxClosed
		
	var chance = randi_range(0, 1)
	if chance == 0:
		_displayText("You failed to evade the " + enemy.enemy_name + ".")
		await self.textBoxClosed
		_enemy_turn()
		return
	
	_displayText("You escaped the " + enemy.enemy_name + ".")
	await self.textBoxClosed
	get_tree().change_scene_to_file("res://scenes/world.tscn")
#end run button pressed

func _ready() -> void:
	uiTextArea.hide()
	uiPlayerActions.hide()
	
	enemy_max_health = enemy.enemy_health
	enemy_health = enemy_max_health
	_updateHealthBar(enemy_health, enemy_max_health, enemy_health_bar)
	
	player_health = PlayerState.health
	player_max_health = PlayerState.max_health
	_updateHealthBar(player_health, player_max_health, player_health_bar)
	
	_displayText("A wild " + enemy.enemy_name + " appears!")
	await self.textBoxClosed
	uiPlayerActions.show()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and uiTextArea.visible:
		uiTextArea.hide()
		emit_signal("textBoxClosed")
