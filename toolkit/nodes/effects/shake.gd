extends Effect

var PossibleDirections = [Vector2.UP, Vector2.UP + Vector2.RIGHT, Vector2.RIGHT, Vector2.RIGHT + Vector2.DOWN, Vector2.DOWN, Vector2.DOWN + Vector2.LEFT, Vector2.LEFT, Vector2.LEFT + Vector2.UP]

var distance = 5.0

func start_effect(parent_node) -> void:
	var original_position = parent_node.position
	PossibleDirections.shuffle()
	var tween = create_tween()
	tween.set_parallel(false)
	for x in 2:
		tween.tween_property(parent_node, "position", parent_node.position + PossibleDirections[x] * distance, 0.08)
	
	tween.tween_property(parent_node, "position", original_position, 0.08)
	await tween.finished
