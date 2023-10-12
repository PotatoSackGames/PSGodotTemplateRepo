extends Node
class_name StateChart

var _transition_map = {}

@export var TargetActor : Node
@export var InitialState : State

var _current_state : State

func _ready():
	assert(TargetActor != null, "Target actor is null")
	assert(InitialState != null, "Initial state is null")
	for state in get_children():
		assert(state.get_child_count() != 0, "No transitions defined for " + state.name)
		assert(state.get_child_count() == 1, "More than one transition for " + state.name)

		var transition = state.get_child(0)
		register_transition_for_state(state, transition)

	await transition_to(InitialState)
	
func register_transition_for_state(parent_state : State, transition : StateTransition):
	_transition_map[parent_state] = transition
	parent_state.actor = TargetActor # Would rather have this anywhere else, but it only makes sense here because transitions can be late-registered using this function. Ugly, but only way to allow dynamic usage.

func transition_to(state : State):
	assert(_current_state != null, "Current state is somehow null")
	var prev_state = _current_state
	await _current_state.exit(state)
	_current_state = state
	await _current_state.get_child(0)._transition_to(prev_state, self)
	await _current_state.enter(prev_state, self)
