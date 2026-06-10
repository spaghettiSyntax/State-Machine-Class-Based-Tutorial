class_name StateWalk
extends StateBase


func _ready() -> void:
	state_color = Color.LIME_GREEN
	
	
func process_physics(_delta: float) -> StateBase:
	var direction: float = Input.get_axis("move_left", "move_right")
	player.velocity.x = direction * player.SPEED
	
	# Face the way we move! signf gives -1, 0 or 1 no matter what the float is on direction!
	match signf(direction):
		-1.0:
			player.body_visual.scale.x = -1.0
		1.0:
			player.body_visual.scale.x = 1.0
	
	# Add this to every state you can launch flight from! 
	if player.can_fly and Input.is_action_just_pressed("fly_up"):
		return player.get_state(&"FLY")
	
	# Dash wins! It needs to remember which way we are facing.
	if Input.is_action_just_pressed("dash") and player.can_jump():
		player.dash_direction = direction if direction != 0.0 else player.body_visual.scale.x
		return player.get_state(&"DASH")
		
	if direction == 0.0:
		return player.get_state(&"IDLE")
	elif Input.is_action_just_pressed("jump") and player.can_jump():
		return player.get_state(&"JUMP")
	elif not player.can_jump():
		return player.get_state(&"FALL")
	
	return self
