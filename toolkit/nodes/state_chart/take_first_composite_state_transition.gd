extends StateTransition
class_name TakeFirstStateTransition


# Important to note that this has no transition of its own, i.e. it is an auto-complete if there are no children;
# however, we assert that there must be at least one child for sanity sake. If no transitions hit, it does not
# go to the resulting to state, which _is_ defined by this transition.

# Transitions using the first transition which matches from a list of possible transitions

func _transition_to(from_state, state_chart):
	_validate()
	

func should_transition(from_state, actor):
	_validate()
	
	var should_transit = true
	for child in get_children():
		should_transit = child.should_transition(from_state, actor)
		if should_transit:
			break
	
	return should_transit

func _validate():
	assert(get_children().size() > 0, "No child states in composite state " + name)
	
