extends Node2D
class_name Effect

# Base class for any sort of special effect; inherit this and add your special code under the overridden start_effect function
# The parent_node is the parent of the effect, in case you need access to that.
# See how the special effects like squash and stretch function in the /effects folder.

signal effect_completed

func start_effect(parent_node) -> void:
	pass
