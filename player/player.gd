extends CharacterBody2D


# const
const SPEED = 125

# @onready var
@onready var all_interactions = []
@onready var interact_label: Label = $Interact/InteractLabel
@onready var sprite: Sprite2D = $Sprite2D
@onready var ui_manager: CanvasLayer = %UIManager


# ====================================================================================================
#
# Main functions
func _ready():
	SignalBus._computer_says.connect(computerSays)
	SignalBus._speech.connect(speech)
	update_interactions()

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction (-1, 0, 1) and use it to handle how we flip the sprite horizontally
	var direction := Input.get_axis('move_left', 'move_right')
	handleSpriteFlip(direction)

	# Apply directional movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Handle inputs
	if Input.is_action_just_pressed('interact'):
		execute_interaction()

# ====================================================================================================
#
# Signal functions
#
# Interact
func _on_interact_area_entered(area: Area2D):
	SignalBus._computer_says.emit('Entered ' + area.name)
	all_interactions.push_front(area)
	update_interactions()

func _on_interact_area_exited(area: Area2D):
	SignalBus._computer_says.emit('Exited ' + area.name)
	all_interactions.erase(area)
	update_interactions()

# ====================================================================================================
#
# Helper functions
func handleSpriteFlip(direction: float):
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true

# SignalBus
func computerSays(message: String):
	var activity = ui_manager.get_node('MasterContainer/ComputerSays/OuterContainer/InnerContainer/ScrollContainer/Activity')

	if activity.text.length() == 0:
		activity.text += message
	else:
		activity.text += ('\n' + message)

func speech(message: String):
	var speech = ui_manager.get_node('MasterContainer/Speech')
	var speech_text = ui_manager.get_node('MasterContainer/Speech/ScrollContainer/MarginContainer/SpeechText')
	var speech_timer = ui_manager.get_node('MasterContainer/Speech/SpeechTimer')

	speech.visible = true
	speech_text.text = message
	speech_timer.start()

# Interact
func execute_interaction():
	if all_interactions:
		var current_interaction = all_interactions[0]
		SignalBus._computer_says.emit('Interacted with ' + current_interaction.id)
		SignalBus._speech.emit(current_interaction.value)

func update_interactions():
	if all_interactions:
		var current_interaction = all_interactions[0]

		interact_label.text = current_interaction.label
	else:
		interact_label.text = ''
