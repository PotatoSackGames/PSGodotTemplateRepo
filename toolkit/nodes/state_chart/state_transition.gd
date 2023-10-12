extends Node
class_name StateTransition

@export var ToState : Node

func _transition_to(from_state, state_chart):
	await on_transition_to(from_state, state_chart)
	
func on_transition_to(from_state, state_chart):
	pass
	
func should_transition(from_state, actor):
	pass
