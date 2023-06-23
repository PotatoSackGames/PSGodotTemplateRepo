extends CanvasLayer

@onready var _anim = $AnimationPlayer


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
	$CRTScreen.hide()

func turn_on_crt():
	$CRTScreen.show()
