extends Node

var _state = { "current_perspective" : Types.PerspectiveType.Topdown }

func _ready():
	if not SaverLoader.file_exists("Blackboard"):
		SaverLoader.save_data("Blackboard", _state)

func has_entry(key : String) -> bool:
	return _state.has(key)

func has_entries(keys : Array[String]) -> bool:
	return _state.has_all(keys)
