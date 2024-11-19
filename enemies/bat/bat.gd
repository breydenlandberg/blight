extends CharacterBody2D


# ====================================================================================================
#
# Main functions
func _ready():
	EnemyManager.loadEnemy(self)
