@tool
extends Node

# Hold onto game state; this can be loaded with SaverLoader, and can be manipulated
# with set_item_state(property_name, property_value). Retrieve it if you wish by simply using GSM.property_name.

# This absolutely hijacks the Godot property system and makes it so whenever you set the game state with
# GameStateManager.set_item_state(property_name, property_value), you can then just call GSM.property_name and it'll return the value to you.
# Mind that if you do not set the value first, it will throw an error!

# Note I have not solved how to make this work with a setting just yet due to some internal safety checks that Godot has.

var _game_state : Array[Dictionary]

func _enter_tree():
	_game_state = get_property_list()
	
func _get(property):
	for item in _game_state:
		if item.name == property:
			if item.has("value"):
				return item.value
			else:
				return item
	
	assert(false, "Property " + property + " has not had set_item_state called on it initially")
	return null
	
func set_item_state(item_id : String, state : Variant):
	_game_state.append({"name": item_id, "type": typeof(state), "value": state })

func has_item_state(item_id):
	return _game_state.has(item_id)
