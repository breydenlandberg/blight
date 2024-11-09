class_name Ground extends State


# @export var
@export var jump_velocity: float = -250
@onready var sprite: Sprite2D = $"../../Sprite2D"


# ====================================================================================================
#
# Functions inherited from State class
func enter():
	SignalBus._attack.connect(attack)

	if previous_state and previous_state.name.to_lower() == 'air' and entity.velocity.length() == 0:
		animation.play('land')


func state_input(event: InputEvent):
	if entity.is_on_floor(): # Because are on the ground
		if event.is_action_pressed('jump'):
			jump()
		if event.is_action_pressed('attack_basic'):
			SignalBus._attack.emit('attack_basic')
			SignalBus._computer_says.emit('attack_basic')

func state_physics_process(delta):
	if attack_animation.current_animation != 'attack_basic' and attack_animation.current_animation != 'attack_basic_flip_h':
		entity.is_attacking = false

	if entity.is_on_floor():
		if playerCanPlayDefaultAnim():
			if entity.velocity.length() > 0:
				animation.play('run')
			else:
				animation.play('idle')
	else:
		_transition.emit(self, 'air')

# ====================================================================================================
#
# Ground state specific functions
func attack(attack_type: String):
	entity.is_attacking = true
	animation.play(attack_type)

	if sprite.flip_h:
		attack_animation.play(attack_type + '_flip_h')
	else:
		attack_animation.play(attack_type)

func jump():
	entity.velocity.y = jump_velocity
	
	if animation.current_animation != 'attack_basic':
		animation.play('jump')

func playerCanPlayDefaultAnim() -> bool:
	match animation.current_animation:
		'land':
			return false
		'attack_basic':
			return false
		_:
			return true
