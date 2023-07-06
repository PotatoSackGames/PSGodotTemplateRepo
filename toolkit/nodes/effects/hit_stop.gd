extends Effect

@export var HitStopTexture : Texture
@export var TimeInHitStop : float

func start_effect(parent_node) -> void:
	var current_image = parent_node.texture.duplicate()
	parent_node.texture = HitStopTexture
	await get_tree().create_timer(TimeInHitStop).timeout
	parent_node.texture = current_image
