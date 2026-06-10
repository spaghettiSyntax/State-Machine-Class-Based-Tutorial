class_name StateHurt
extends StateBase

@export var hurt_duration: float = 0.6

var _timer: float = 0.0


func _ready() -> void:
	state_color = Color.RED
	
	
func enter() -> void:
	_timer = hurt_duration
	
	
func process_physics(delta: float) -> StateBase:
	player.velocity.x = move_toward(player.velocity.x, 0.0, player.SPEED * 3.0)
	_timer -= delta
	
	if _timer <= 0.0:
		# Respawn at the latest checkpoint! Then return to idle
		player.global_position = player.respawn_point
		player.velocity = Vector2.ZERO
		return player.get_state(&"IDLE")
	
	return self
