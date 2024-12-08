class_name Attack extends State


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
	target_player(delta)

# ====================================================================================================
#
# Helper functions
func target_player(delta: float):
	player_position = tentaclime.player.position
	target_position = (player_position - tentaclime.position).normalized()

	if tentaclime.position.distance_to(player_position) > 3:
		tentaclime.position += target_position * tentaclime.speed * delta
