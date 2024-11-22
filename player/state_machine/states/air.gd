class_name Air extends State


# ====================================================================================================
# Default animations: fall
# Possible animations: attack_basic, jump

# Possible attack animations: attack_basic, attack_basic_flip_h


# var
var player: CharacterBody2D
var has_double_jumped = false

# @export var
@export var double_jump_velocity: float = -250


# ====================================================================================================
#
# Functions inherited from State class
func enter():
	player = entity

func exit():
	has_double_jumped = false

func state_input(event: InputEvent):
	if event.is_action_pressed('jump') and not has_double_jumped:
		double_jump()
	if event.is_action_pressed('attack_basic'):
			if not player.is_attacking:
				attack_basic()

func state_physics_process(delta):
	if player.is_on_floor():
		_transition.emit(self, 'ground')
	else:
		if playerCanPlayDefaultAnim():
			animation.play('fall')

# ====================================================================================================
#
# Air state specific functions
func attack_basic():
	player.is_attacking = true
	player.speed = player.BASE_SPEED * 0.25
	#print('player is attacking')

	animation.play('attack_basic')

	if sprite.flip_h:
		attack_animation.play('attack_basic_flip_h')
	else:
		attack_animation.play('attack_basic')

func double_jump():
	player.velocity.y = double_jump_velocity

	if not player.is_attacking:
		animation.stop()
		animation.play('jump')

	has_double_jumped = true

func playerCanPlayDefaultAnim() -> bool:
	match animation.current_animation:
		'attack_basic', 'jump':
			return false
		_:
			if player.is_attacking:
				return false
			else:
				return true

# ====================================================================================================
#
# Signal functions
#
# 
