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

func _ready():
	_parent = get_parent()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.seed = randi()
	noise.frequency = 1.0 / 4.0
	noise.fractal_octaves = 2
	_initial_offset = offset
	_initial_pos = global_position

func set_trauma(value) -> void:
	trauma = value

func add_trauma(amount = 0):
	trauma = min(trauma + amount, 1.0)

func _process(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()

func move_along_path(path : Array):
	var tween = create_tween()
	tween.set_parallel(false)
	tween.set_trans(Tween.TRANS_LINEAR)
	var previous = path[0].global_position
	for point in path:
		var distance = previous.distance_to(point.global_position)
		tween.tween_property(self, "global_position", point.global_position, distance / 400.0)
		previous = point.global_position
				
	await tween.finished
	done_moving.emit()

func shake():
	var amount = pow(trauma, trauma_power)
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y) + _initial_offset.x
	offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y) + _initial_offset.y

func reset_camera() -> void:
	position = Vector2.ZERO

func handle_input(event: InputEvent) -> void:
	if rotation == 0.0:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
			_mouse_down = event.is_pressed()
		elif event is InputEventMouseMotion and _mouse_down:
			global_position -= event.relative
			_initial_pos = global_position
