extends CanvasLayer

@onready var _anim = $AnimationPlayer

func transition_out() -> void:
	_anim.play("End")
	await _anim.animation_finished

func transition_in() -> void:
	_anim.play("Start")
	await _anim.animation_finished

func turn_off_crt():
	$CRTScreen.hide()

func turn_on_crt():
	$CRTScreen.show()
