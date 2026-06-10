class_name Player
extends CharacterBody2D


# Going further! Coyote time
const COYOTE_TIME: float = 0.2
var _coyote_timer: float = 0.0


# CONSTANTS
const SPEED: float = 200.0
const JUMP_VELOCITY: float = -450.0
const GRAVITY: float = 980.0
const DASH_SPEED: float = 400.0

# White state to start in, and is just a name that matches
# the child node under States node in the Player scene
@export var initial_state_name: StringName = &"IDLE"

# NODE REFERENCES
@onready var body_visual: Polygon2D = $BodyVisual
@onready var state_label: Label = $StateLabel
@onready var states: StateBase = $States

var respawn_point: Vector2 = Vector2(200.0, 488.0)
var current_state: StateBase
var dash_direction: float = 1.0
var can_fly: bool = true

var _states: Dictionary[StringName, StateBase] = {}


func _ready() -> void:
	# Cache every state and hand it a reference back to this player.
	for child: Node in states.get_children():
		if child is StateBase:
			var state: StateBase = child as StateBase
			state.player = self
			_states[child.name] = state

	current_state = get_state(initial_state_name)
	if current_state != null:
		current_state.enter()
	

func _physics_process(delta: float) -> void:
	# Going further! Coyote time
	_update_coyote_timer(delta)
	
	_apply_gravity(delta)
	var next_state: StateBase = current_state.process_physics(delta)
	_change_state(next_state)
	move_and_slide()
	_update_visuals()


func _apply_gravity(delta: float) -> void:
	# Only apply when airborne
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
		
# HELPERS

# Fetch a state by its node name
func get_state(state_name: StringName) -> StateBase:
	if not _states.has(state_name):
		push_warning("No state named '%s' under States. Check the node name!" % state_name)
		return null
	return _states[state_name]
	
	
func enter_state_by_name(state_name: StringName) -> void:
	_change_state(get_state(state_name))
	
	
func _change_state(new_state: StateBase) -> void:
	if new_state == null or new_state == current_state:
		return
		
	current_state.exit()
	current_state = new_state
	current_state.enter()


func _update_visuals() -> void:
	body_visual.color = current_state.state_color
	state_label.text = current_state.name
	
	
# Grant temporary flight. Call this from a pickup, 
# an input, or a spell system!
func grant_flight(duration: float) -> void:
	can_fly = true
	get_tree().create_timer(duration).timeout.connect(func() -> void: can_fly = false)
	
	
	
	
# Optional: runtime add/remove (add to player.gd)
 
# Add a state to the machine while the game runs like the moment a spell casts.
func register_state(state: StateBase) -> void:
	states.add_child(state)
	state.player = self
	_states[state.name] = state
 
 
# Remove a state while the game runs. NEVER remove the state you are currently
# in, transition out first, or you'll free a node mid-update.
func unregister_state(state_name: StringName) -> void:
	if not _states.has(state_name):
		return
	_states[state_name].queue_free()
	_states.erase(state_name)


# Going further! Coyote time
func _update_coyote_timer(delta: float) -> void:
	if is_on_floor():
		_coyote_timer = COYOTE_TIME
	else:
		_coyote_timer -= delta
		

# A few frames of grace after leaving a ledge. IDLE and WALK check
# this instead of is_on_floor() 
func can_jump() -> bool:
	return _coyote_timer > 0.0
