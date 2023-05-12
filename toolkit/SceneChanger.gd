extends Node

func change_scene_to(scene_path : String, stack_option = SceneStack.StackOptions.none):
	await Transition.transition_out()
	SceneStack.show_scene(scene_path, stack_option)
	await Transition.transition_in()

func close_scene():
	await Transition.transition_out()
	SceneStack.show_previous_scene()
	await Transition.transition_in()

func change_scene_to_file(scene, stack_option = SceneStack.StackOptions.none):
	await Transition.transition_out()
	SceneStack.show_scene_file(scene, stack_option)
	await Transition.transition_in()
