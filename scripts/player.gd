extends CharacterBody2D

#movement
var player_walk_speed:int = 250
var player_walk_animation_speed:float = 1.0
var player_run_speed:int = 600
var player_run_animation_speed:float = 2.5
var player_movement_direction:String = "right"
var player_is_running:bool = false

#misc
@onready var playerSprite:AnimatedSprite2D = get_node("playerSprite")

func playerMovement() -> void:
	#velocity in this context is a property of CharacterBody2D
	velocity = Input.get_vector("left", "right", "up", "down") #grab the velocity vector from the input mapping ending up with a range between -1 and +1
	player_is_running = Input.is_action_pressed("run")
	
	var player_speed = player_run_speed if player_is_running else player_walk_speed #change speed value based on "is running"
	velocity = velocity.normalized() * player_speed #normalize the values and then multiplywdsds by player speed
	
	move_and_slide()#envoke physics process to handle the actual movement
	#end playerMovement

func playerMovementAnimation() -> void:
	if velocity.x > 0:
		player_movement_direction = "right"
	elif velocity.x < 0:
		player_movement_direction = "left"
	elif velocity.y > 0:
		player_movement_direction = "down"
	elif velocity.y < 0:
		player_movement_direction = "up"
		
	if velocity == Vector2.ZERO: #we aren't moving
		playerSprite.play("idle_" + player_movement_direction)
	else:
		var animation_speed = player_run_animation_speed if player_is_running else player_walk_animation_speed
		playerSprite.play("walk_" + player_movement_direction, animation_speed)

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("testTrigger"):
		PlayerState.last_position = self.position #we can do this because this script is directly attached to the player scene
		get_tree().change_scene_to_file("res://scenes/battle.tscn")
	
	playerMovement()
	playerMovementAnimation()
