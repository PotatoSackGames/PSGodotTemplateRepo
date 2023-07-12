# Code adapted and expanded from uHeartbeast's turn-based course, with permission! Find
# his course here: https://courses.heartgamedev.com/

extends Node

var _stack = []

enum StackOptions { none, push }

# Not sure if these actually run if not in the scene tree; actually pretty sure they don't. Still worth it.
const StoppableFunctions = ["set_process_unhandled_input", "set_process_input", "set_process_unhandled_key_input", "set_physics_process", "set_process"]

# But this may be able to help with signal issues
const ReverseStoppableFunctions = ["set_block_signals"]

func show_scene(scene_path : String, stack_option = StackOptions.none):
	if stack_option == StackOptions.push:
		var next_scene = load(scene_path).instantiate()

		var current_scene = get_tree().current_scene
		_stack.push_back(current_scene)
		_stop_functions(current_scene)
		get_tree().root.remove_child(current_scene)
		get_tree().root.add_child(next_scene)
		get_tree().current_scene = next_scene
	else:
		get_tree().change_scene_to_file(scene_path)
		
func show_scene_file(scene, stack_option = StackOptions.none):
	if stack_option == StackOptions.push:
		var next_scene = scene

		var current_scene = get_tree().current_scene
		_stack.push_back(current_scene)
		_stop_functions(current_scene)
		get_tree().root.remove_child(current_scene)
		get_tree().root.add_child(next_scene)
		get_tree().current_scene = next_scene

func show_previous_scene():
	if _stack.size() > 0:
		var previous_scene = _stack.pop_back()
		get_tree().root.remove_child(get_tree().current_scene)
		get_tree().root.add_child(previous_scene)
		get_tree().current_scene = previous_scene
		_start_functions(previous_scene)


func _stop_functions(scene):
	for function in StoppableFunctions:
		scene.call(function, false)

	for function in ReverseStoppableFunctions:
		scene.call(function, true)

func _start_functions(scene):
	for function in StoppableFunctions:
		scene.call(function, true)

	for function in ReverseStoppableFunctions:
		scene.call(function, false)
