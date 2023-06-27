# Majority of code modified from https://kidscancode.org/godot_recipes/3.x/2d/screen_shake/index.html. Thanks KidsCanCode!
extends Camera2D

signal done_moving()

@export var decay = 0.8  # How quickly the shaking stops [0, 1].
@export var max_offset = Vector2(100, 75)  # Maximum hor/ver shake in pixels.
@export var max_roll = 0.1  # Maximum rotation in radians (use sparingly).
@export var can_move := true

var trauma = 0.0  # Current shake strength.
var trauma_power = 2  # Trauma exponent. Use [2, 3].

@onready var noise = FastNoiseLite.new()
var noise_y = 0

var _initial_offset
var _initial_pos
var _mouse_down

var _parent

var _window_size = Vector2(int(ProjectSettings.get_setting("display/window/size/viewport_width")), int(ProjectSettings.get_setting("display/window/size/viewport_height")))

func _ready():
	_parent = get_parent()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.seed = randi()
	noise.frequency = 1.0 / 4.0
	noise.fractal_octaves = 2
	_initial_offset = offset # Note the original code incorrectly handles the initial offset, and as such
	# it can cause weirdness if you try to set the offset yourself and expect it to stay relative to where
	# you've set it. By storing the initial offset here, we can add it back in after the shake has occurred.
	_initial_pos = global_position

# The default trauma value
func set_trauma(value) -> void:
	trauma = value

# Add whatever level of trauma you want; vary this depending on how hard you want the camera to shake.
# It can be WILD, so be careful.
func add_trauma(amount = 0):
	trauma = min(trauma + amount, 1.0)

func _process(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		_shake()


# Call this with an array of Marker2Ds (or any kind of Node2D) to move the camera along the given
# path. At the moment, the speed is scaled by a constant amount, but this can be normalized
# however you wish.
func move_along_path(path : Array):
	var tween = create_tween()
	tween.set_parallel(false)
	tween.set_trans(Tween.TRANS_LINEAR)
	var previous = path[0].global_position
	for point in path:
		var distance = previous.distance_to(point.global_position)
		# change the following line to normalize the speed; distance / 400.0 is a random value I picked
		# that looked good for a game once.
		tween.tween_property(self, "global_position", point.global_position, distance / 400.0)
		previous = point.global_position
				
	await tween.finished
	done_moving.emit()

# Generally speaking, you won't call this; call add_trauma to make it go nuts
func _shake():
	var amount = pow(trauma, trauma_power)
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y) + _initial_offset.x
	offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y) + _initial_offset.y

# resets the position of the camera to _initial_pos
func reset_camera() -> void:
	position = _initial_pos

# If you call this from a parent, you can actually move the camera around using the right mouse button.
# Call reset_camera afterward if you want the camera to go back to its original position
func handle_input(event: InputEvent) -> void:
	if rotation == 0.0:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
			_mouse_down = event.is_pressed()
		elif event is InputEventMouseMotion and _mouse_down:
			global_position -= event.relative
			_initial_pos = global_position

# Moves the camera exactly one screen in any direction (provided by the parameter). Note direction
# should be normalized, but technically does not have to be; since we do not normalize it, if you
# use a non-normalized vector, it will go further/shorter than one full screen.
# Note also this doesn't handle 
func move(direction : Vector2, in_time : float = 0.2) -> void:
	var multiplier = _window_size.x if direction.x != 0 else _window_size.y
	var tween = create_tween()
	tween.tween_property(self, "global_position", direction * multiplier + global_position, in_time)
	await tween.finished
