extends Node2D


# var
var current_interaction: Interaction
var executed_interactions: Array[Interaction]
var interactions: Array[Interaction]
var interact_label: Label
var player: CharacterBody2D


# ====================================================================================================
#
# Functions
func erase(interaction: Interaction):
	interactions.erase(interaction)
	current_interaction = interactions.front()

	#print('InteractManager.erase()')
	#print('interactions: ', interactions)
	#print('current_interaction: ', current_interaction)
	#print('\n')

func execute_current_interaction():
	var current_interaction_temp = current_interaction

	if not executed_interactions.has(current_interaction_temp):
		match current_interaction_temp.type:
			'text':
				current_interaction_temp.get_node('TextContainer/TextLabel').text = current_interaction.value

		executed_interactions.push_front(current_interaction_temp)
		print('executed_interactions: ', executed_interactions)
		print('\n')

		await get_tree().create_timer(current_interaction_temp.duration).timeout

		executed_interactions.remove_at(executed_interactions.find(current_interaction_temp))
		print('executed_interactions: ', executed_interactions)
		print('\n')

		match current_interaction_temp.type:
			'text':
				current_interaction_temp.get_node('TextContainer/TextLabel').text = ''

func push_front(interaction: Interaction):
	interactions.push_front(interaction)
	current_interaction = interactions.front()

	#print('InteractManager.push_front()')
	#print('interactions: ', interactions)
	#print('current_interaction: ', current_interaction)
	#print('\n')

func set_player(player_param: CharacterBody2D):
	player = player_param
	interact_label = player.get_node('Interact/InteractLabel')

func update_interact_label():
	if current_interaction and interactions:
		interact_label.text = current_interaction.label
	else:
		interact_label.text = ''
