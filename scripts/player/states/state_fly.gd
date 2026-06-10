class_name StateFly
extends StateBase


@export var fly_speed: float = 250.0


func _ready() -> void:
	state_color = Color.AQUAMARINE
	

func enter() -> void:
	player.velocity.y = -fly_speed


func process_physics(_delta: float) -> StateBase:
	if not player.can_fly:
		return player.get_state(&"FALL")
	if player.is_on_floor():
		return player.get_state(&"LAND")
		
		
	var direction: float = Input.get_axis("move_left", "move_right")
	player.velocity.x = direction * player.SPEED
	
	# Face the way we move! signf gives -1, 0 or 1 no matter what the float is on direction!
	match signf(direction):
		-1.0:
			player.body_visual.scale.x = -1.0
		1.0:
			player.body_visual.scale.x = 1.0
			
	var lift: float = Input.get_axis("fly_down", "fly_up")
	player.velocity.y = -lift * fly_speed
		
	return self
