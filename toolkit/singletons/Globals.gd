extends Node

# For custom global data
# add_if_unsupported will add a specific key to your global data if the key you pass in wasn't found

var GlobalData = { "can_double_jump" : false }

func supports(key):
	if GlobalData.has(key):
		return GlobalData[key]
	
	return false

func add_if_unsupported(key, default_value : bool = false):
	if not GlobalData.has(key):
		GlobalData.add(key, default_value)

# Uncomment if you add a ui_exit input to your input map that you want to use to go back to the previous scene
# for testing purposes. Make sure to comment this out before publishing your game! (Or remove ui_exit from the map.)
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_exit"):
		SceneChanger.close_scene()

