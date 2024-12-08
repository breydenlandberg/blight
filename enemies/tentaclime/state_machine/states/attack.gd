class_name Attack extends State


# @onready var
@onready var ray_cast_right_down: RayCast2D = $"../../RayCastRightDown"
@onready var ray_cast_left_down: RayCast2D = $"../../RayCastLeftDown"

# var
var player_position: Vector2
var target_position: Vector2
var tentaclime: CharacterBody2D


# ====================================================================================================
#
# Functions inherited from State class
func enter():
	tentaclime = entity

	print('Entering Tentaclime Attack State!')
	print('\n')

	tentaclime.speed = tentaclime.base_speed * 2
	animation.play('run')

func exit():
	print('Exiting Tentaclime Attack State!')
	print('\n')

	tentaclime.speed = tentaclime.base_speed

func state_physics_process(delta):
	if ray_cast_left_down.is_colliding() and ray_cast_right_down.is_colliding():
		target_player(delta)
	else:
		animation.play('idle')

	handle_sprite_flip()

# ====================================================================================================
#
# Helper functions
func handle_sprite_flip():
	print('player_position', player_position)
	print('target_position', target_position)
	print('\n')

	if target_position.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func target_player(delta: float):
	if ray_cast_left_down.is_colliding() and ray_cast_right_down.is_colliding():
		player_position = tentaclime.player.position
		target_position = (player_position - tentaclime.position).normalized()

		if tentaclime.position.distance_to(player_position) > 3:
			tentaclime.position += target_position * tentaclime.speed * delta
