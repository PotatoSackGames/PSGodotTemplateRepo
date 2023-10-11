extends AudioStreamPlayer
class_name MouseoverControlSFX

@export var SfxStream : AudioStream
@export var Target : Control

func _ready():
	assert(Target != null, "Target of MouseoverControlSFX node is null")
	assert(SfxStream != null, "No stream defined for MouseoverControlSFX node")
	
	if not Target.mouse_entered.is_connected(_on_mouse_entered):
		Target.mouse_entered.connect(_on_mouse_entered)
	
	stream = SfxStream
	
func _on_mouse_entered():
	if not playing:
		play()
