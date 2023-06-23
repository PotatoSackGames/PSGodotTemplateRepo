extends VisibleOnScreenNotifier2D

# automatically resets the parent node with some real trickery

var _parent : Node2D
var _parents_parent
var _initial_pos : Vector2

# This callable can be used to determine if the scene should reset; return a true value if the state of the game is such that it should, false otherwise
var ShouldResetTest : Callable

@export @onready var OnScreenEntered : bool # Have to disable warnings for this, which sucks, but can be done specific to this error

func _ready() -> void:
	_parent = get_parent()
	assert(_parent != null, "Parent was null")
	_parents_parent = _parent.get_parent()
		
	if OnScreenEntered and not screen_entered.is_connected(on_screen_changed):
		screen_entered.connect(on_screen_changed)
	elif not OnScreenEntered and not screen_exited.is_connected(on_screen_changed):
		screen_exited.connect(on_screen_changed)

func _process(delta: float) -> void:
	_initial_pos = _parent.global_position # To ensure ready has run and the initial position of the node is set; ugly, but only way without awaiting or having an obtuse timer.
	set_process(false)

# Add whatever functionality you like; happens either on entered or exited
func on_screen_changed() -> void:
	pass

# Override this to change the functionality if you want; note it only accounts for position,
# and other properties such as rotation and scale can be set here as well, but are not
# accounted for by default
func reset_scene() -> void:
	if ShouldResetTest.is_valid():
		if not ShouldResetTest.call():
			return

	var type_path = _parent.scene_file_path
	var new_version = load(type_path)
	var new_node = new_version.instantiate()
	_parent.queue_free()
	_parents_parent.add_child(new_node)
	new_node.global_position = _initial_pos
