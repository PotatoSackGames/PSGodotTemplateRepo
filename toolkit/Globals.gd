extends Node

var GlobalData = { "SupportsDoubleJump" : false }

func supports(key : String):
	if GlobalData.has(key):
		return GlobalData[key]
	
	return false

func add_if_unsupported(key : String, default_value : bool = false):
	if not GlobalData.has(key):
		GlobalData.add(key, default_value)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_exit"):
		SceneChanger.close_scene()
