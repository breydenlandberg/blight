class_name Ground extends State


# var
var player: CharacterBody2D

# @onready var
@onready var sprite: Sprite2D = $"../../Sprite2D"

# @export var
@export var jump_velocity: float = -250


# ====================================================================================================
#
# Functions inherited from State class
func enter():
	player = entity

	if previous_state and previous_state.name.to_lower() == 'air' and player.velocity.length() == 0:
		animation.play('land')

func state_input(event: InputEvent):
	if player.is_on_floor(): # Because are on the ground
		if event.is_action_pressed('jump'):
			jump()
		if event.is_action_pressed('attack_basic'):
			if not player.is_attacking:
				attack('attack_basic')

func state_physics_process(delta):
	if player.is_on_floor():
		if playerCanPlayDefaultAnim():
			if player.velocity.length() > 0:
				animation.play('run')
			else:
				animation.play('idle')
	else:
		_transition.emit(self, 'air')

# ====================================================================================================
#
# Ground state specific functions
func attack(attack_type: String):
	player.is_attacking = true
	player.speed = player.BASE_SPEED * 0.25
	print('player is attacking')
	
	animation.play(attack_type)

	if sprite.flip_h:
		attack_animation.play(attack_type + '_flip_h')
		print('player attacked using: ' + attack_type + '_flip_h')
	else:
		attack_animation.play(attack_type)
		print('player attacked using: ' + attack_type)

func jump():
	player.velocity.y = jump_velocity
	
	if animation.current_animation != 'attack_basic':
		animation.play('jump')

func playerCanPlayDefaultAnim() -> bool:
	match animation.current_animation:
		'land', 'attack_basic':
			return false
		_:
			return true

# ====================================================================================================
#
# Signal functions
#
# Attack
func _on_basic_attack_hitbox_body_entered(body: Node2D) -> void:
	SignalBus._computer_says.emit('Player hit ' + body.name + ' with basic attack')
	# WHAT GOES IN STATE AND WHAT GOES IN PLAYER !!!

func _on_attack_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		'attack_basic', 'attack_basic_flip_h':
			player.is_attacking = false
			player.speed = player.BASE_SPEED
			print('player is no longer attacking')
