extends Node
class_name StateMachine

# Use the below to create a type of state machine called a push-down automata. 
# States are below that for a standard character that can support dashing, jumping, and more. Note you'll have to
# modify it for your usecase - this is just an example provided for your learning!

class PDA:
	var stack = []

	func push(state : State):
		if stack.size() > 0:
			stack[-1].exit(state)
		stack.append(state)
		state.enter(stack.size() > 1 if stack[stack.size() - 2] != null else null)
		Debug.info("Entering state: " + state.get_script().to_string())

	func pop():
		var prev_state = stack.pop_back()
		Debug.info("Leaving state: " + prev_state.get_script().to_string())
		prev_state.exit(stack.size() > 0 if stack.back() != null else null)
		if stack.size() > 0:
			stack.back().enter(prev_state)
		return prev_state

	func pop_and_push(state : State):
		pop()
		push(state)


class State:
	var _character # Reference to character
	
	var Gravity = ProjectSettings.get("physics/2d/default_gravity") # most states can or will need to reference this

	func _init(character):
		_character = character

	func enter(previous_state : State):
		pass

	func exit(next_state : State):
		pass

	func physics_process(delta : float):
		pass


# The below is an example of how to implement the states for a normal character controller
# that allows for dashing. 

# Player
#
#class Idle extends State:
#	func enter(previous_state):
#		_character.state_machine.stack = []
#		_character.state_machine.stack.append(self)
#		_character.play_animation("Idle")
#		_character.velocity.x = 0.0
#
#	func physics_process(delta):
#		if _character.is_moving():
#			_character.state_machine.push(Move.new(_character))
#			return
#		if _character.is_jumping():
#			_character.state_machine.push(Jump.new(_character))
#
#class Move extends State:
#	var direction = Vector2.ZERO
#
#	func enter(previous_state):
#		_character.play_animation("Move")
#		_character.move_speed = 200.0
#
#	func physics_process(delta):
#		direction = Vector2.ZERO
#		if Input.is_action_pressed("ui_right"):
#			direction.x += 1
#		if Input.is_action_pressed("ui_left"):
#			direction.x -= 1
#
#		if direction.length() > 0:
#			_character.velocity = Vector2(direction.normalized().x * _character.move_speed, _character.velocity.y)
#		else:
#			_character.state_machine.pop_and_push(Idle.new(_character))
#
#		if _character.is_jumping():
#			_character.state_machine.push(Jump.new(_character))
#
#		if _character.is_dashing():
#			_character.state_machine.push(Dash.new(_character))
#
#		if _character.is_falling():
#			_character.state_machine.push(Falling.new(_character))
#
#class Dash extends State:
#	var dash_speed = 500 # Change as needed
#	var dash_direction = Vector2.ZERO
#	var dash_timer = 0.5 # Dash duration in seconds
#
#	func enter(previous_state):
#		_character.play_animation("Dash")
#		dash_direction = Vector2(_character.sign_x, 0)
#		dash_timer = 0.5
#		_character.last_dash_time = Time.get_ticks_msec()
#		_character.move_speed = dash_speed
#
#	func physics_process(delta):			
#		if dash_timer > 0:
#			_character.velocity = dash_direction * _character.move_speed + Vector2(0.0, _character.velocity.y)
#			dash_timer -= delta
#
#			if _character.is_jumping():
#				_character.state_machine.pop_and_push(Jump.new(_character))
#		else:
#			if _character.is_moving():
#				_character.state_machine.pop_and_push(Move.new(_character))
#			elif _character.is_falling():
#				_character.state_machine.pop_and_push(Falling.new(_character))
#			else:
#				_character.state_machine.pop_and_push(Idle.new(_character))
#
#class Jump extends State:
#	var jump_speed = -400 # Change as needed
#
#	func enter(previous_state):
#		if not previous_state is Jump:
#			_character.play_animation("Jump")
#			_character.velocity.y = jump_speed
#
#	func physics_process(delta):
#		var direction = Vector2.ZERO
#		if Input.is_action_pressed("ui_right"):
#			direction.x += 1
#		if Input.is_action_pressed("ui_left"):
#			direction.x -= 1
#
#		_character.velocity.x = direction.x * _character.move_speed
#		if _character.is_on_floor():
#			if _character.is_moving():
#				_character.state_machine.pop_and_push(Move.new(_character))
#			else:
#				_character.state_machine.pop_and_push(Idle.new(_character))
#		else:
#			if _character.is_falling():
#				_character.state_machine.pop_and_push(Falling.new(_character))
#
#		if _character.is_dashing():
#			_character.state_machine.pop_and_push(Dash.new(_character))
#
#class Falling extends State:
#	func enter(previous_state):
#		_character.play_animation("Fall")
#		if not _character.state_machine.stack.any(func(state): state is Jump):
#			_character.coyote_timer = _character.coyote_time
#
#	func physics_process(delta):		
#		var direction = Vector2.ZERO
#		if Input.is_action_pressed("ui_right"):
#			direction.x += 1
#		if Input.is_action_pressed("ui_left"):
#			direction.x -= 1
#
#		_character.velocity.x = direction.x * _character.move_speed
#		if _character.is_on_floor():
#			if _character.is_moving():
#				_character.state_machine.pop_and_push(Move.new(_character))
#			else:
#				_character.state_machine.pop_and_push(Idle.new(_character))
#
#		if _character.is_jumping() and _character.coyote_time > 0.0:
#			_character.state_machine.pop_and_push(Jump.new(_character))
#
#		if _character.is_dashing():
#			_character.state_machine.pop_and_push(Dash.new(_character))
