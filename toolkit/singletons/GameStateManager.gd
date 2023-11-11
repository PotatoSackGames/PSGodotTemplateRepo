@tool
extends Node

# Hold onto game state; this can be loaded with SaverLoader, and can be manipulated
# as if it has any property you want to use. You can just call GSM.Thing1 = "blah", and you can
# then use GSM.Thing1 later. You don't have to declare Thing1 on this class for that to function.

# Note that the getter will actually throw an error, intentionally, if the property does not 
# exist when you go to get it.

# Thanks to @assertchris on Mastodon for implementing the setter method, and simplifying the getter.

var _game_state : Dictionary = {}
	
func _get(property):
	if _game_state.has(property):	
		return _game_state[property]

	return null
	
func _set(property, value):
	_game_state[property] = value
	return true
