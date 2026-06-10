# Conceptual: factor today's loop into a reusable StateMachine node, then the
# player ticks TWO of them, one for movement, one for actions, side by side.
class_name StateMachine 
extends Node
 
var current_state: StateBase
var _states: Dictionary[StringName, StateBase] = {}
 
 
func tick(delta: float) -> void:
	var next_state: StateBase = current_state.process_physics(delta)
	if next_state != null and next_state != current_state:
		current_state.exit()
		current_state = next_state
		current_state.enter()
