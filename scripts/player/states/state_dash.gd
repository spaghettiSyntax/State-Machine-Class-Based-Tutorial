class_name StateDash
extends StateBase

@export var dash_duration: float = 0.2

var _timer: float = 0.0


func _ready() -> void:
	state_color = Color.DEEP_SKY_BLUE
	
	
func enter() -> void:
	_timer = dash_duration


func exit() -> void:
	# Don't let the dash raw speed leak into the next state!
	player.velocity.x = clampf(player.velocity.x, -player.SPEED, player.SPEED)
	
	
func process_physics(delta: float) -> StateBase:
	player.velocity.x = player.dash_direction * player.DASH_SPEED
	_timer -= delta
	
	if _timer <= 0.0:
		var direction: float = Input.get_axis("move_left", "move_right")
		if direction != 0.0:
			return player.get_state(&"WALK")
		return player.get_state(&"IDLE")
	
	return self
