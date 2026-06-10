class_name StateBase
extends Node

## Contract injects itself into 'player' on ready, 
## so no state ever wires that reference by hand!
var player: Player

var state_color: Color = Color.WHITE

## Runs ONCE, the instant this state becomes active we can
## setup whichever state calls it. (i.e. launch/jump impulses, starting timers)
func enter() -> void:
	pass
	

## Runs ONCE, the instant this state is replaced.
## Things like resetting flags like bools, or clamping, etc.
func exit() -> void:
	pass
	
	
## Runs EVERY physics fram while this state is active.
## Return the state to run next frame, or 'self' to stay put.
func process_physics(_delta: float) -> StateBase:
	return self
