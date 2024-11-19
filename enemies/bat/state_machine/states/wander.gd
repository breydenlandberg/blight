class_name Wander extends State


# const
const speed = 25

# var
var bat: CharacterBody2D
var move_right: bool # Can we just map this to -1, 1, maybe via ternerary operator and be done with it, so that we can just use direction like normal

# @onready var
@onready var ray_cast_right: RayCast2D = $"../../RayCastRight"
@onready var ray_cast_left: RayCast2D = $"../../RayCastLeft"
@onready var ray_cast_right_down: RayCast2D = $"../../RayCastRightDown"
@onready var ray_cast_left_down: RayCast2D = $"../../RayCastLeftDown"


# ====================================================================================================
#
# Functions inherited from State class
func enter():
	bat = entity

	animation.play('run')
	
	# Choose whether the bat wanders right or left. 0 = move left, 1 = move right
	move_right = bool(randi_range(0, 1))

	# Wander for a number of seconds in the randf_range
	var wander_length = randf_range(3, 6)
	#print(bat.name + ' is wandering to the ' + ('right' if move_right else 'left') + ' for ' + str(wander_length) + ' seconds')
	await get_tree().create_timer(wander_length).timeout

	_transition.emit(self, 'idle')

func state_physics_process(delta):
	# What if neither are colliding?
	# What about gravity? The bat needs to adhere to the ground? (Apply gravity in bat.gd maybe)
	# Ensure collision with world works as expected.
	if move_right:
		if ray_cast_right_down.is_colliding():
			sprite.flip_h = true
			bat.position.x += speed * delta
		else:
			move_right = false
	else:
		if ray_cast_left_down.is_colliding():
			sprite.flip_h = false
			bat.position.x -= speed * delta
		else:
			move_right = true

# ====================================================================================================
#
# Wander state specific functions
