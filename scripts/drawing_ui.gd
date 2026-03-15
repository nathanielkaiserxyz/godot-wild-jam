extends Control

var drawing: bool = false
var current_line: Line2D

func _input(event):
	if not visible: 
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			drawing = true
			current_line = Line2D.new()
			current_line.default_color = Color.GOLD
			current_line.width = 5.0
			add_child(current_line)
			current_line.add_point(get_local_mouse_position())
		else:
			drawing = false

	if event is InputEventMouseMotion and drawing:
		current_line.add_point(get_local_mouse_position())

func _on_button_pressed() -> void:
	self.visible = false
	get_tree().paused = false 
