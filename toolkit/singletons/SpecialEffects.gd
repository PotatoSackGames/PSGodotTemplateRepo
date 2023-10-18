extends Node

# Use these functions to add special effects to your game that go away after a period of time;
# this ensures that you won't have to create a bunch of custom timers for your temporary special effects.
# Note that the in_time variable and in_times below require it be somewhere around close to the total
# time of your special effect, or the individual times of each special effect (in the multi-effect case).

static func add_temporary_effect_to(effect_scene, in_time : float, node) -> Effect:
	var effect = effect_scene.instantiate()
	return add_premade_temporary_effect_to(effect, in_time, node)

# Adds an effect that is already created/preloaded

static func add_premade_temporary_effect_to(effect, in_time : float, node) -> Effect:
	var detachable = Detachable.new()
	detachable.TimeToComplete = in_time # Would prefer to make this something awaitable. Still considering it.
	assert(effect is Effect, "Effect_scene did not produce an effect type")
	detachable.add_child(effect)
	node.add_child(detachable)
	effect.start_effect(node)
	return effect


# A multi-effect adds a set of effects that act in series, each one after in_time amount of time.
# Similar can be added to achieve a parallel set of effects if desired.
static func add_temporary_multi_effect_to(effect_scenes : Array[PackedScene], in_times : Array[float], node) -> void:
	var detachable = Detachable.new()
	var serial_effect = preload("res://Toolkit/Nodes/effects/serial_effect.tscn").instantiate()
	var total_time = 0.0
	for i in effect_scenes.size():
		total_time += in_times[i]
		serial_effect.add_effect(effect_scenes[i], in_times[i])
	
	detachable.add_child(serial_effect)
	node.add_child(detachable)
	detachable.TimeToComplete = total_time
	serial_effect.start_effect(node)
	

# A multi-effect adds a set of effects that act in parallel, finishing after the time has elapsed.
static func add_temporary_parallel_multi_effect_to(effect_scenes : Array[PackedScene], in_time, node) -> void:
	var detachable = Detachable.new()
	var parallel_effect = preload("res://Toolkit/Nodes/effects/parallel_effect.tscn").instantiate()
	
	for i in effect_scenes.size():
		parallel_effect.add_effect(effect_scenes[i])
	
	detachable.add_child(parallel_effect)
	node.add_child(detachable)
	detachable.TimeToComplete = in_time
	parallel_effect.start_effect(node)
	
