extends CharacterBody2D


# @export var
@export var attackable := true
@export var base_damage := 5
@export var health := 10


# ====================================================================================================
#
# Main functions
func _ready():
	EntityManager.load_entity(self)

# ====================================================================================================
#
# Helper functions
func die():
	#animation.play('die')
	queue_free()
