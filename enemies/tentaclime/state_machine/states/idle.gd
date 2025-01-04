class_name Idle extends State


# @onready var
@onready var timer: Timer = $"../../IdleTimer"

# var
var tentaclime: CharacterBody2D


# ====================================================================================================
#
# Functions inherited from State class
func enter():
	tentaclime = entity

	tentaclime.direction = 0

	animation.play('idle')

	# Idle for a number of seconds in the randf_range
	var idle_length = randf_range(3, 6)

	#print(tentaclime.name, ' is idle for ', idle_length, ' seconds')
	#print('\n')

	timer.start(idle_length)

func exit():
	timer.stop()

# ====================================================================================================
#
# Signal functions
func _on_animation_player_animation_finished(anim_name: StringName):
	animation.play('idle')

func _on_idle_timer_timeout() -> void:
	_transition.emit(self, 'wander')
