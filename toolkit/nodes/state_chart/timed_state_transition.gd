extends StateTransition
class_name TimedStateTransition

@export var TimeToTransition : float

func _transition_to(from_state, state_chart):
	await get_tree().create_timer(TimeToTransition).timeout
	await on_transition_to(from_state, state_chart)
