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

	#print('Entering ', tentaclime.name, ' Attack State!')
	#print('\n')

	tentaclime.speed = tentaclime.base_speed * 2

func exit():
	#print('Exiting ', tentaclime.name, ' Attack State!')
	#print('\n')

	tentaclime.speed = tentaclime.base_speed

func state_physics_process(delta):
	#print('player_position', player_position)
	#print('target_position', target_position)
	#print('\n')

	if not animation.current_animation == 'take_damage':
		if tentaclime.velocity.is_zero_approx():
			animation.play('idle')
		else:
			animation.play('run')

	target_player(delta)

	handle_sprite_flip()

# ====================================================================================================
#
# Helper functions
func handle_sprite_flip():
	if target_position.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func target_player(delta: float):
	player_position = tentaclime.player.position
	target_position = (player_position - tentaclime.position).normalized()

	if ray_cast_left_down.is_colliding() and ray_cast_right_down.is_colliding():
		if tentaclime.position.distance_to(player_position) > 21:
			if target_position.x < 0:
				tentaclime.direction = -1
			else:
				tentaclime.direction = 1
		else:
			tentaclime.direction = 0

	elif not ray_cast_left_down.is_colliding() and ray_cast_right_down.is_colliding():
		if tentaclime.position.distance_to(player_position) > 21 and target_position.x > 0:
			tentaclime.direction = 1
		else:
			tentaclime.direction = 0

	elif ray_cast_left_down.is_colliding() and not ray_cast_right_down.is_colliding():
		if tentaclime.position.distance_to(player_position) > 21 and target_position.x < 0:
			tentaclime.direction = -1
		else:
			tentaclime.direction = 0
