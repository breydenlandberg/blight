class_name Idle extends State


# ====================================================================================================
#
# Functions inherited from State class
func enter():
	animation.play('idle')

	# Idle for a number of seconds in the randf_range
	var idle_length = randf_range(3, 6)
	print(entity.name + ' is idle for ' + str(idle_length) + ' seconds')
	await get_tree().create_timer(idle_length).timeout

	_transition.emit(self, 'wander')
