class_name Ground extends State


# @export var
@export var jump_velocity: float = -250


# ====================================================================================================
#
# Functions inherited from State class
func enter():
	if previous_state and previous_state.name.to_lower() == 'air' and entity.velocity.length() == 0:
		animation.play('land')

func state_input(event: InputEvent):
	if event.is_action_pressed('jump') and entity.is_on_floor():
		jump()

func state_physics_process(delta):
	if entity.is_on_floor():
		if animation.current_animation != 'land':
			if entity.velocity.length() > 0:
				animation.play('run')
			else:
				animation.play('idle')
	else:
		_transition.emit(self, 'air')

# ====================================================================================================
#
# Ground state specific functions
func jump():
	entity.velocity.y = jump_velocity
	animation.play('jump')
