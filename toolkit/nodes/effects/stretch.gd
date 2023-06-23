extends Effect

const ScaleTime = .1

func start_effect(parent_node) -> void:
	var original_scale = parent_node.scale
	var new_scale = Vector2(parent_node.scale.x, parent_node.scale.y * 1.5)
	var tween = get_tree().create_tween()
	tween.set_parallel(false)
	tween.tween_property(parent_node, "scale", new_scale, ScaleTime)
	tween.tween_property(parent_node, "scale", original_scale, ScaleTime)
	await tween.finished
