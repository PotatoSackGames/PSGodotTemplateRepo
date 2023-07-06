extends "res://toolkit/nodes/effects/shader_swap.gd"

func between_steps(parent_node) -> void:
	var anim = load("res://toolkit/nodes/effects/damage_animationplayer.tscn").instantiate()
	parent_node.add_child(anim)
	anim.play("Damage")
	await anim.animation_finished
	anim.queue_free()
