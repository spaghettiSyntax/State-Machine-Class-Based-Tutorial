class_name Hazard
extends Area2D

# Which state to force on contact, by NAME!
@export var trigger_state_name: StringName = &"HURT"


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		(body as Player).enter_state_by_name(trigger_state_name)
