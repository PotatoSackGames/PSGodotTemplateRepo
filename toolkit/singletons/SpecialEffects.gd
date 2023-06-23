extends Node

static func add_temporary_effect_to(effect_scene, in_time : float, node) -> Effect:
	var effect = effect_scene.instantiate()
	var detachable = Detachable.new()
	detachable.TimeToComplete = in_time # Would prefer to make this something awaitable. Still considering it.
	assert(effect is Effect, "Effect_scene did not produce an effect type")
	detachable.add_child(effect)
	node.add_child(detachable)
	effect.start_effect(node)
	return effect

static func add_temporary_multi_effect_to(effect_scenes : Array[PackedScene], in_times : Array[float], node) -> void:
	var detachable = Detachable.new()
	var serial_effect = preload("res://toolkit/nodes/effects/serial_effect.tscn").instantiate()
	var total_time = 0.0
	for i in effect_scenes.size():
		total_time += in_times[i]
		serial_effect.add_effect(effect_scenes[i], in_times[i])
	
	detachable.add_child(serial_effect)
	node.add_child(detachable)
	detachable.TimeToComplete = total_time
	serial_effect.start_effect(node)
	
