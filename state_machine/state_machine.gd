class_name StateMachine extends Node2D


# var
var states: Dictionary
var current_state: State

# @export var
@export var animation: AnimationPlayer
@export var attack_animation: AnimationPlayer
@export var entity: CharacterBody2D
@export var initial_state: State


# ====================================================================================================
#
# To be used in child StateMachines that inherit from this parent class, e.g. PlayerStateMachine,
# BatStateMachine, etc.
#
# Used in _input
func handle_input(event: InputEvent):
	if current_state:
		current_state.state_input(event)

# Used in _process
func handle_process(delta):
	if current_state:
		current_state.state_process(delta)

# Used in _physics_process
func handle_physics_process(delta):
	if current_state:
		current_state.state_physics_process(delta)

# Used in _ready
func set_up_state_machine():
	# Set up states
	for child in get_children():
		if child is State:
			child.animation = animation
			child.attack_animation = attack_animation
			child.entity = entity

			states[child.name.to_lower()] = child

			child._transition.connect(transition)
		else:
			push_warning('Child \'' + child.name + '\' is not a valid State for the ' + entity.name + 'StateMachine')

	if initial_state:
		initial_state.enter()
		current_state = initial_state

# ====================================================================================================
#
# Helper functions
#
# Connect to State _transition signal
func transition(state, new_state_name):
	if state != current_state:
		push_warning('Passed state \'' + state.name.to_lower() + '\' does not equal current state \'' + current_state.name + '\'')
		return

	SignalBus._computer_says.emit(entity.name + ' OLD state: ' + state.name.to_lower() + ' | NEW state: ' + new_state_name)

	var new_state = states.get(new_state_name.to_lower())

	if !new_state:
		push_warning('New state not found')
		return

	if current_state:
		current_state.exit()
		current_state.previous_state = null

	new_state.previous_state = current_state
	new_state.enter()

	current_state = new_state
