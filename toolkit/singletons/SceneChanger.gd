# Changes scenes. Used with Transition singleton to ensure that you transition out and in any time it's called.
# This can be easily commented out if you want to do your own transitions.
extends Node

# Call this if you want to change scenes to a file at scene_path
func change_scene_to(scene_path : String, stack_option = SceneStack.StackOptions.none):
	await Transition.transition_out()
	SceneStack.show_scene(scene_path, stack_option)
	await Transition.transition_in()

func close_scene():
	await Transition.transition_out()
	SceneStack.show_previous_scene()
	await Transition.transition_in()

# Call this if you want to change the current scene to a pre-instantiated scene
func change_scene_to_file(scene, stack_option = SceneStack.StackOptions.none):
	await Transition.transition_out()
	SceneStack.show_scene_file(scene, stack_option)
	await Transition.transition_in()
