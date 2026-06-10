class_name StateIdle
extends StateBase


func _ready() -> void:
	state_color = Color.CORNFLOWER_BLUE
	
	
func process_physics(_delta: float) -> StateBase:
	player.velocity.x = move_toward(player.velocity.x, 0.0, player.SPEED)
	
	var direction: float = Input.get_axis("move_left", "move_right")
	
	# Add this to every state you can launch flight from! 
	if player.can_fly and Input.is_action_just_pressed("fly_up"):
		return player.get_state(&"FLY")
	
	# Dash wins! It needs to remember which way we are facing.
	if Input.is_action_just_pressed("dash") and player.can_jump():
		player.dash_direction = direction if direction != 0.0 else player.body_visual.scale.x
		return player.get_state(&"DASH")
		
	if direction != 0.0:
		return player.get_state(&"WALK")
	elif Input.is_action_just_pressed("jump") and player.can_jump():
		return player.get_state(&"JUMP")
	elif not player.can_jump():
		return player.get_state(&"FALL")
	
	return self
