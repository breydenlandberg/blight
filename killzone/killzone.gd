extends Area2D


@onready var timer: Timer = $Timer
@onready var player: CharacterBody2D = $"../Player"


# ====================================================================================================
#
# Signal functions
func _on_body_entered(body: Node2D):
	if body == player:
		SignalBus._message.emit('You killed yourself')
		timer.start()
	else:
		SignalBus._message.emit(str(body) + ' killed themself')
		body.queue_free()
		print('Queue freeing the node: ', body)

	print('\n')

func _on_timer_timeout():
	EntityManager.reset()
	InteractManager.reset()
	get_tree().reload_current_scene()
