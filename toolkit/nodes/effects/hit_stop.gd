extends Effect

@export var HitStopTexture : Texture
@export var TimeInHitStop : float
@export var IsFramebased : bool
@export var FrameNumber : int

func start_effect(parent_node) -> void:
	if not IsFramebased:
		var current_image = parent_node.texture.duplicate()
		parent_node.texture = HitStopTexture
		await get_tree().create_timer(TimeInHitStop).timeout
		parent_node.texture = current_image
	else:
		var previous_frame = parent_node.frame
		parent_node.frame = FrameNumber
		await get_tree().create_timer(TimeInHitStop).timeout
		parent_node.frame = previous_frame
