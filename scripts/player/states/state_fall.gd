class_name StateFall
extends StateBase


func _ready() -> void:
	state_color = Color.ORANGE
	

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
			
	if player.is_on_floor():
		return player.get_state(&"LAND")
	
	return self
