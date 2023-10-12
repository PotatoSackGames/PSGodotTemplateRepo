extends StateTransition

@export var TargetAnimationPlayer : AnimationPlayer
@export var TargetAnimation : String

func _transition_to(from_state, state_chart):
	assert(TargetAnimationPlayer != null, "TargetAnimationPlayer null for state transition " + name)
	assert(TargetAnimation != null, "TargetAnimation null for state transition " + name)
	
	TargetAnimationPlayer.play(TargetAnimation)
	await TargetAnimationPlayer.animation_finished
	await on_transition_to(from_state, state_chart)
