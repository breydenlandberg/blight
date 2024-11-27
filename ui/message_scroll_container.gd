extends ScrollContainer


# var
var max_scroll_length = 0

# @onready var
@onready var scrollbar = get_v_scroll_bar()


# ====================================================================================================
#
# Main functions
func _ready():
	scrollbar.changed.connect(handle_scrollbar_changed)
	max_scroll_length = scrollbar.max_value

# ====================================================================================================
#
# Helper functions
func handle_scrollbar_changed():
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		self.scroll_vertical = max_scroll_length
