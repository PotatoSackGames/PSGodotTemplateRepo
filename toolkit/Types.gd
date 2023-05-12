extends Node
class_name Types

enum PerspectiveType { Topdown, Side }
enum EnvironmentType { Forest, Brick, Mountain, Grass, Desert }

static func map_selector(from_scene : String, env : EnvironmentType, perspective : PerspectiveType) -> String:
	var file = "res://"
	if perspective == PerspectiveType.Topdown:
		file += "test_scenes/topdown_world_test_scene_1.tscn"
	else:
		file += "test_scenes/test_platformer_level_1.tscn"
	
	# later, use environment type to pick the right scene from the side scroller
	return file
