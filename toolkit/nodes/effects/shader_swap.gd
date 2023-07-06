extends Effect

@export var ShaderMat : Material

func start_effect(parent_node) -> void:
	await get_tree().process_frame
	var shader = parent_node.material
	parent_node.material = ShaderMat
	await between_steps(parent_node)
	parent_node.material = shader
	
func between_steps(parent_node) -> void:
	pass
