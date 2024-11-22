extends CharacterBody2D


# const
var BASE_SPEED := 125

# var
var direction: float
var is_attacking := false
var speed := BASE_SPEED

# @onready var
@onready var all_interactions = []
@onready var interact_label: Label = $Interact/InteractLabel
@onready var sprite: Sprite2D = $Sprite2D
@onready var ui_manager: CanvasLayer = %UIManager

# @export var
@export var base_damage := 5
@export var energy := 100
@export var health := 100


# ====================================================================================================
#
# Main functions
func _ready():
	SignalBus._computer_says.connect(computerSays)
	SignalBus._speech.connect(speech)
	update_interactions()

func _physics_process(delta: float):
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction (-1, 0, 1) and use it to handle how we flip the sprite horizontally
	direction = Input.get_axis('move_left', 'move_right')

	handleSpriteFlip(direction)
	handleDirectionalMovement()
	move_and_slide()
	handleInput()

# ====================================================================================================
#
# Helper functions
func handleDirectionalMovement():
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

func handleInput():
	if Input.is_action_just_pressed('interact'):
		execute_interaction()

func handleSpriteFlip(direction: float):
	if not is_attacking:
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

# Attack
func _on_attack_animation_player_animation_finished(anim_name: StringName):
	match anim_name:
		'attack_basic', 'attack_basic_flip_h':
			is_attacking = false
			speed = BASE_SPEED

func _on_basic_attack_hitbox_body_entered(body: Node2D):
	EntityManager.deal_damage(body, base_damage)
