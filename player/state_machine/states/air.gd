class_name Air extends State


# var
var has_double_jumped = false

# @export var
@export var double_jump_velocity: float = -250


# ====================================================================================================
#
# Functions inherited from State class
func enter():
	if animation.current_animation != 'jump' and animation.current_animation != 'attack_basic':
		animation.play('fall')

func exit():
	has_double_jumped = false

func state_input(event: InputEvent):
	if event.is_action_pressed('jump') and not has_double_jumped:
		double_jump()

func state_physics_process(delta):
	if entity.is_on_floor():
		_transition.emit(self, 'ground')

# ====================================================================================================
#
# Air state specific functions
func double_jump():
	entity.velocity.y = double_jump_velocity
	
	if animation.current_animation != 'attack_basic':
		animation.stop()
		animation.play('jump')

	has_double_jumped = true
