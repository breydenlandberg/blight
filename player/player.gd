extends CharacterBody2D


# @onready var
@onready var all_interactions = []
@onready var interact_label: Label = $Interact/InteractLabel
@onready var sprite: Sprite2D = $Sprite2D
@onready var ui_manager: CanvasLayer = %UIManager

# @export var
@export var base_damage := 5
@export var base_speed := 125
@export var energy := 100
@export var health := 100

# var
var direction: float
var is_attacking := false
var speed := base_speed


# ====================================================================================================
#
# Main functions
func _ready():
	InteractManager.set_player(self)
	# Maybe below doesn't need to be a signal?
	SignalBus._message.connect(message)

func _physics_process(delta: float):
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction (-1, 0, 1) and use it to handle how we flip the sprite horizontally
	direction = Input.get_axis('move_left', 'move_right')

	handle_sprite_flip()
	handle_directional_movement()
	move_and_slide()

	handle_input()

# ====================================================================================================
#
# Helper functions
func handle_directional_movement():
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

func handle_input():
	if Input.is_action_just_pressed('interact'):
		InteractManager.execute_current_interaction()

func handle_sprite_flip():
	if not is_attacking:
		if direction > 0:
			sprite.flip_h = false
		elif direction < 0:
			sprite.flip_h = true

# SignalBus
func message(message: String):
	var message_text = ui_manager.get_node('MasterContainer/Message/PanelContainer/MarginContainer/ScrollContainer/MessageText')

	if message_text.text.length() == 0:
		message_text.text += message
	else:
		message_text.text += ('\n' + message)

# ====================================================================================================
#
# Signal functions
#
# Interact
func _on_interact_area_entered(interaction: Interaction):
	InteractManager.push_front(interaction)
	InteractManager.update_interact_label()

func _on_interact_area_exited(interaction: Interaction):
	InteractManager.erase(interaction)
	InteractManager.update_interact_label()

# Attack
func _on_attack_animation_player_animation_finished(anim_name: StringName):
	match anim_name:
		'attack_basic', 'attack_basic_flip_h':
			is_attacking = false
			speed = base_speed

func _on_basic_attack_hitbox_body_entered(body: Node2D):
	EntityManager.deal_damage(body, base_damage)
