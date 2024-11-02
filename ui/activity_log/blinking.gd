extends Label


# var
var time = 0
var sinTime = 0
var _visible = true

# @export var
@export var speed: int = 2
@export var fade: bool = false


# ====================================================================================================
#
# Main functions
func _physics_process(delta: float) -> void:
	time += delta
	sinTime = sin(time * speed)
	blink()

# ====================================================================================================
#
# Helper functions
func blink():
	if !fade:
		if sinTime > 0:
			_visible = true
		else:
			_visible = false
	else:
		_visible = true
		modulate.a = sinTime
	visible = _visible
