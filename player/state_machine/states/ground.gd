class_name Ground extends State


# ====================================================================================================
# Default animations: idle, run
# Possible animations: attack_basic, land

# Possible attack animations: attack_basic, attack_basic_flip_h


# var
var player: CharacterBody2D

# @export var
@export var jump_velocity: float = -250


# ====================================================================================================
#
# Functions inherited from State class
func enter():
	player = entity

	if previous_state and previous_state.name.to_lower() == 'air' and player.velocity.length() == 0 and not player.is_attacking:
		animation.play('land')

func state_input(event: InputEvent):
	if player.is_on_floor(): # Because are on the ground
		if event.is_action_pressed('jump'):
			jump()
		if event.is_action_pressed('attack_basic'):
			if not player.is_attacking:
				attack_basic()

func state_physics_process(delta):
	if player.is_on_floor():
		if playerCanPlayDefaultAnim():
			if player.velocity.length() > 0:
				animation.play('run')
			else:
				animation.play('idle')
	else:
		_transition.emit(self, 'air')

# ====================================================================================================
#
# Ground state specific functions
func attack_basic():
	player.is_attacking = true
	player.speed = player.base_speed * 0.25

	animation.play('attack_basic')

	if sprite.flip_h:
		attack_animation.play('attack_basic_flip_h')
	else:
		attack_animation.play('attack_basic')

func jump():
	player.velocity.y = jump_velocity
	
	if animation.current_animation != 'attack_basic':
		animation.play('jump')

func playerCanPlayDefaultAnim() -> bool:
	match animation.current_animation:
		'attack_basic', 'land':
			return false
		_:
			if player.is_attacking:
				return false
			else:
				return true
