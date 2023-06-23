extends Effect

var _effect_scenes = []

func add_effect(effect_scene, in_time : float) -> void:
	_effect_scenes.push_back({ "scene": effect_scene, "time" : in_time })

func start_effect(parent_node) -> void:
	for scene_pair in _effect_scenes:
		var node = scene_pair.scene.instantiate()
		add_child(node)
		await node.start_effect(parent_node)
		
