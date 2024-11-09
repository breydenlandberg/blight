class_name State extends Node2D


# signals
signal _transition(state, new_state_name)

# var
var animation: AnimationPlayer
var attack_animation: AnimationPlayer
var entity: CharacterBody2D
var previous_state: State


# ====================================================================================================
#
# Override methods. Implement these in our states.
#
# Used when entering a new_state
func enter():
	pass

# Used when exiting the current_state
func exit():
	pass

# Handle an input event in the current state
func state_input(event: InputEvent):
	pass

# Whenever the state machine is processing, we also want the current state to process (NON-PHYSICS)
func state_process(delta):
	pass

# Whenever the state machine is processing, we also want the current state to process (PHYSICS)
func state_physics_process(delta):
	pass
