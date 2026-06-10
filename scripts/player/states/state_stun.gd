class_name StateStun
extends StateBase


@export var stun_duration: float = 0.3

var _timer: float = 0.0


func _ready() -> void:
	state_color = Color.MEDIUM_PURPLE
	
	
func enter() -> void:
	_timer = stun_duration
	
	
func process_physics(delta: float) -> StateBase:
	player.velocity.x = move_toward(player.velocity.x, 0.0, player.SPEED * 5.0)
	_timer -= delta
	
	if _timer <= 0.0:
		return player.get_state(&"IDLE")
	
	return self
