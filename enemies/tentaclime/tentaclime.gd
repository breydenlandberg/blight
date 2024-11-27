extends CharacterBody2D


# @onready var
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: TentaclimeStateMachine = $TentaclimeStateMachine

# @export var
@export var attackable := true
@export var base_damage := 5
@export var base_speed := 25
@export var health := 20

# var
var direction: int
var speed := base_speed


# ====================================================================================================
#
# Main functions
func _ready():
	EntityManager.load_entity(self)

func _physics_process(delta: float):
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	handleSpriteFlip(direction)
	handleDirectionalMovement()
	move_and_slide()

# ====================================================================================================
#
# Helper functions
func die():
	state_machine.transition(state_machine.current_state, 'die')

func handleDirectionalMovement():
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

func handleSpriteFlip(direction: float):
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true
