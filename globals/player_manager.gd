extends Node2D


# var
var player: CharacterBody2D

var health := 100

var attack_basic_damage := 1


# ====================================================================================================
#
# Functions
func loadPlayer(player_param: CharacterBody2D):
	player = player_param
	print(player)

# ====================================================================================================
#
# Signals
