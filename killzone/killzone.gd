extends Area2D


@onready var timer: Timer = $Timer


# ====================================================================================================
#
# Signal functions
func _on_body_entered(body: Node2D):
	SignalBus._computer_says.emit('You killed yourself')
	timer.start()

func _on_timer_timeout():
	EntityManager.reset()
	get_tree().reload_current_scene()
