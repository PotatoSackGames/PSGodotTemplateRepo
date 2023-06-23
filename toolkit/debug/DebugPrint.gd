extends VBoxContainer

const InfoLabel = preload("res://toolkit/debug/info_label.tscn")
const ErrorLabel = preload("res://toolkit/debug/error_label.tscn")

func info(text : String):
	_add_text(text, InfoLabel)

func error(text : String):
	_add_text(text, ErrorLabel)
	
func _add_text(text : String, packed_scene : PackedScene):
	var scene = packed_scene.instantiate()
	scene.set_text_internal(text)
	add_child(scene)
