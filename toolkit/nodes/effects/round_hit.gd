extends Effect

var _round_hit_image = preload("res://toolkit/nodes/effects/RoundHitImage.tscn")

func start_effect(parent_node) -> void:
	var image = _round_hit_image.instantiate()
	parent_node.add_child(image)
	var tween = create_tween()
	tween.set_parallel(false)
	tween.tween_property(image, "scale", Vector2(1.3, 1.3), .05)
	tween.tween_property(image, "scale", Vector2(.8, .8), .05)
	tween.tween_property(image, "scale", Vector2(1.3, 1.3), .05)
	tween.tween_property(image, "scale", Vector2(.8, .8), .05)
	await tween.finished
	image.queue_free()
