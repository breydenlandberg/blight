extends Node2D


# @onready var
@onready var speech_text: Label = $ScrollContainer/MarginContainer/SpeechText


# ====================================================================================================
#
# Main functions
func _on_speech_timer_timeout() -> void:
	speech_text.text = ''
	visible = false
