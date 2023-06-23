extends Node2D
class_name Detachable

@export var TimeToComplete : float

var _current_time : float = 0.0

func _process(delta: float) -> void:
	_current_time += delta
	if _current_time >= TimeToComplete:
		queue_free()
