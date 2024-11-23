class_name TentaclimeStateMachine extends StateMachine


# ====================================================================================================
#
# Main functions
func _input(event: InputEvent):
	handle_input(event)

func _process(delta):
	handle_process(delta)

func _physics_process(delta):
	handle_physics_process(delta)

func _ready():
	set_up_state_machine()
