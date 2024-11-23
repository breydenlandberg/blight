class_name Idle extends State


var tentaclime: CharacterBody2D


# ====================================================================================================
#
# Functions inherited from State class
func enter():
	tentaclime = entity

	animation.play('idle')

	# Idle for a number of seconds in the randf_range
	var idle_length = randf_range(3, 6)

	#print(tentaclime.name, ' is idle for ', idle_length, ' seconds')
	#print('\n')

	await get_tree().create_timer(idle_length).timeout

	_transition.emit(self, 'wander')
