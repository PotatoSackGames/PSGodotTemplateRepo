extends Node2D
class_name Detachable

# Create this scene, add it to the tree, and add another node to it (with a time) in order to have a temporary
# node that frees itself after the appropriate time has elapsed; this is particularly useful for special effects,
# timed attacks, particle effects that go away after a period of time, and so on.

@export var TimeToComplete : float

var _current_time : float = 0.0

func _process(delta: float) -> void:
	_current_time += delta
	if _current_time >= TimeToComplete:
		queue_free()
