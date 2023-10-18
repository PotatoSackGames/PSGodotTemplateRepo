extends Effect

# Handle shaking - courtesy of KidsCanCode
@export var decay := 0.8  # How quickly the shaking stops [0, 1].
@export var max_offset := Vector2(75, 75)  # Maximum hor/ver shake in pixels.
@export var max_roll := 0.1  # Maximum rotation in radians (use sparingly).

@onready var noise = FastNoiseLite.new()
var noise_y = 0

var trauma = .6  # Current shake strength.
var trauma_power = 2  # Trauma exponent. Use [2, 3].

var _node
var _original_offset

func _ready():
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.seed = randi() / 3
	noise.frequency = 1.0 / 4.0
	noise.fractal_octaves = 2

func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)

func _process(delta):
	if trauma > 0:
		trauma = max(trauma - decay * delta, 0)
		shake(_node)
	else:
		effect_completed.emit()
		if not _node is Control:
			_node.offset = _original_offset
		else:
			_node.position = _original_offset
		set_process(false)

func shake(node):
	var amount = pow(trauma, trauma_power)
	noise_y += 1
	node.rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	if not node is Control:
		node.offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed * 2, noise_y)
		node.offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed * 3, noise_y)
	else:
		node.position.x = (node.position.x + max_offset.x) * amount * noise.get_noise_2d(noise.seed * 2, noise_y)
		node.position.y = (node.position.x + max_offset.y) * amount * noise.get_noise_2d(noise.seed * 3, noise_y)

func start_effect(parent_node) -> void:
	_node = parent_node
	if not _node is Control:
		_original_offset = _node.offset
	else:
		_original_offset = _node.position
	set_process(true)
	shake(parent_node)
