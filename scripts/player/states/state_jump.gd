class_name StateJump
extends StateBase


func _ready() -> void:
	state_color = Color.YELLOW
	
	
func enter() -> void:
	player.velocity.y = player.JUMP_VELOCITY
	
	
func process_physics(_delta: float) -> StateBase:
	# Gravity is applied by the player and takes over immediately
	# after we jump!
	return player.get_state(&"FALL")
