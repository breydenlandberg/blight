class_name Wander extends State


# const
const speed = 25

# var
var tentaclime: CharacterBody2D

# @onready var
@onready var ray_cast_right: RayCast2D = $"../../RayCastRight"
@onready var ray_cast_left: RayCast2D = $"../../RayCastLeft"
@onready var ray_cast_right_down: RayCast2D = $"../../RayCastRightDown"
@onready var ray_cast_left_down: RayCast2D = $"../../RayCastLeftDown"


# ====================================================================================================
#
# Functions inherited from State class
func enter():
	tentaclime = entity

	animation.play('run')
	
	# Choose whether the tentaclime wanders left or right. (0 mapped to) -1 = move left, 1 = move right
	var direction = randi_range(0, 1)
	if direction == 0:
		direction = -1

	tentaclime.direction = direction

	# Wander for a number of seconds in the randf_range
	var wander_length = randf_range(3, 6)

	#print(tentaclime.name, ' is wandering to the ', 'left' if tentaclime.direction == -1 else 'right', ' for ', wander_length, ' seconds')
	#print('\n')

	await get_tree().create_timer(wander_length).timeout

	_transition.emit(self, 'idle')

func exit():
	tentaclime.direction = 0

func state_physics_process(delta):
	if (tentaclime.direction == 1 and not ray_cast_right_down.is_colliding()) or (tentaclime.direction == -1 and not ray_cast_left_down.is_colliding()):
		tentaclime.direction *= -1
