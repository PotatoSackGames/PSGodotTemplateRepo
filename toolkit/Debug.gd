extends CanvasLayer

var _error_dictionary = {}

func info(text : String, catch_once : bool = true) -> void:
	if catch_once:
		if not _error_dictionary.has(text):
			%Print.info(text)
			_error_dictionary[text] = true
	else:
		%Print.info(text)
	
func error(text : String, catch_once : bool = false) -> void:
	if catch_once:
		if not _error_dictionary.has(text):
			%Print.error(text)
			_error_dictionary[text] = true
	else:
		%Print.error(text)
	
func _process(delta: float) -> void:
	if visible and Input.is_action_just_pressed("toggle_debug"):
		hide()
	elif Input.is_action_just_pressed("toggle_debug"):
		show()
	
		
