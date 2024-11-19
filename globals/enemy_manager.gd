extends Node2D


# var
var enemies: Array[CharacterBody2D]


# ====================================================================================================
#
# Functions
func loadEnemy(enemy: CharacterBody2D):
	enemies.append(enemy)
	print(enemies[enemies.find(enemy)])

# ====================================================================================================
#
# Signals
