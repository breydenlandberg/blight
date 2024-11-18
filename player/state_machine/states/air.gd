class_name Air extends State


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

	if animation.current_animation != 'jump' and animation.current_animation != 'attack_basic':
		animation.play('fall')

func exit():
	has_double_jumped = false

func state_input(event: InputEvent):
	if event.is_action_pressed('jump') and not has_double_jumped:
		double_jump()

func state_physics_process(delta):
	if player.is_on_floor():
		_transition.emit(self, 'ground')

# ====================================================================================================
#
# Air state specific functions
func double_jump():
	player.velocity.y = double_jump_velocity
	
	if animation.current_animation != 'attack_basic':
		animation.stop()
		animation.play('jump')

	has_double_jumped = true

# ====================================================================================================
#
# Signal functions
#
# Attack
func _on_attack_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		'attack_basic', 'attack_basic_flip_h':
			animation.play('fall')
