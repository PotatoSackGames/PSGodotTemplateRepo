extends CanvasLayer

# Used automatically to transition between scenes. Note you can customize this and add a shader to
# the contained ColorRect to achieve some cool effects. Note also you can await the functions
# in case you feel like you need to wait until something is done.

@onready var _anim = $AnimationPlayer
@onready var _crt = $CRTFilter

# Call this to fade out the current scene
# Called automatically from the scene changer
func transition_out() -> void:
	_anim.play("End")
	await _anim.animation_finished

# Call this to fade in the current scene
# Called automatically from the scene changer
func transition_in() -> void:
	_anim.play("Start")
	await _anim.animation_finished


func turn_off_crt():
	_crt.hide()
	
func turn_on_crt():
	_crt.show()
