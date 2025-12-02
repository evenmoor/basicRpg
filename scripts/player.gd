extends CharacterBody2D

#movement
var player_walk_speed:int = 250
var player_run_speed:int = 600
	

func playerMovement() -> void:
	#velocity in this context is a property of CharacterBody2D
	velocity = Input.get_vector("left", "right", "up", "down") #grab the velocity vector from the input mapping ending up with a range between -1 and +1
	var player_speed = player_run_speed if Input.is_action_pressed("run") else player_walk_speed #change speed value based on "is running"
	velocity = velocity.normalized() * player_speed #normalize the values and then multiplywdsds by player speed
	
	move_and_slide()#envoke physics process to handle the actual movement
	#end playerMovement

func _physics_process(_delta: float) -> void:
	playerMovement()
