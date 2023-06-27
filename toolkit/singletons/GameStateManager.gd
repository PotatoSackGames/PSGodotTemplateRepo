extends Node

var _game_state = {}

# Hold onto game state; this can be loaded with SaverLoader, and can be manipulated
# with set_item_state. Retrieve it if you wish with get_item_state.

# has_item_state will check if a specific state exists; if it does not, get_item_state
# will return null, SO BE CAREFUL.

func set_item_state(item_id : String, state : Variant):
	_game_state[item_id] = state

func has_item_state(item_id):
	return _game_state.has(item_id)
	
func get_item_state(item_id):
	if has_item_state(item_id):
		return _game_state[item_id]
		
	return null
