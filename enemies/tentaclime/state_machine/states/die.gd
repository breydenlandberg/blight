class_name Die extends State


var tentaclime: CharacterBody2D


# ====================================================================================================
#
# Functions inherited from State class
func enter():
	tentaclime = entity

	tentaclime.direction = 0

	animation.play('die')

# ====================================================================================================
#
# Signal functions
func _on_animation_player_animation_finished(anim_name: StringName):
	if anim_name == 'die':
		tentaclime.queue_free()
