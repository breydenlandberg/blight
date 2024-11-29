extends Node2D


# var
var current_interaction: Interaction
var current_interaction_executed: bool
var interactions: Array[Interaction]
var interact_label: Label
var player: CharacterBody2D


# ====================================================================================================
#
# Functions
func erase(interaction: Interaction):
	interactions.erase(interaction)

func execute_current_interaction():
	match current_interaction.type:
		'text':
			# Please refactor the below
			current_interaction.get_node('TextLabel').text = current_interaction.value

			current_interaction_executed = true
			update_interact_label()

			await get_tree().create_timer(5).timeout

			current_interaction_executed = false
			update_interact_label()

			current_interaction.get_node('TextLabel').text = ''

func push_front(interaction: Interaction):
	interactions.push_front(interaction)
	current_interaction = interactions.front()

func set_player(player_param: CharacterBody2D):
	player = player_param
	interact_label = player.get_node('Interact/InteractLabel')

func update_interact_label():
	if current_interaction and interactions and not current_interaction_executed:
		interact_label.text = current_interaction.label
	else:
		interact_label.text = ''
