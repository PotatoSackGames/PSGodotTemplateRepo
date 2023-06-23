extends "res://toolkit/debug/DebugLabel.gd"

func set_text_internal(text : String):
	%Label.text = "[color=#FF0000]" + text + "[/color]"
