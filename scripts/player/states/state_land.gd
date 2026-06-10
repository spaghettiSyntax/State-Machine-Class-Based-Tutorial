class_name StateLand
extends StateBase

@export var land_duration: float = 0.15

var _timer: float = 0.0


func _ready() -> void:
	state_color = Color.CORNSILK
	

func enter() -> void:
	_timer = land_duration
	

func process_physics(delta: float) -> StateBase:
	player.velocity.x = move_toward(player.velocity.x, 0.0, player.SPEED * 3.0)
	_timer -= delta
	
	if _timer <= 0.0:
		var direction: float = Input.get_axis("move_left", "move_right")
		if direction != 0.0:
			return player.get_state(&"WALK")
		return player.get_state(&"IDLE")
	
	return self
