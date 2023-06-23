extends Node

var _game_state = {}

func set_item_state(item_id : String, state : Variant):
	_game_state[item_id] = state

func has_item_state(item_id):
	return _game_state.has(item_id)
	
func get_item_state(item_id):
	if has_item_state(item_id):
		return _game_state[item_id]
