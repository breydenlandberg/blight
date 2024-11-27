extends AnimatableBody2D


# @onready var
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var detection: Area2D = $Detection
@onready var ui_manager: CanvasLayer = %UIManager


# ====================================================================================================
#
# Signal functions
func _on_detect_area_body_entered(body: Node2D) -> void:
	animation_player.play('move_right')
	detection.queue_free()
	print('queue free ' + name + ' detection')

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_player.queue_free()
	print('queue free' + name + 'animation_player')
