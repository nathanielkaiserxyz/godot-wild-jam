extends Control

var current_line: Line2D
var drawing: bool = false
@export var canvas_node: NodePath 

func _input(event):
	if not visible: 
		return

	var mouse_pos = get_local_mouse_position()
	var is_inside = $ColorRect.get_rect().has_point(mouse_pos)

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and is_inside:
			drawing = true
			current_line = Line2D.new()
			current_line.default_color = Color.GOLD
			current_line.width = 5.0
			add_child(current_line)
		else:
			drawing = false

	if event is InputEventMouseMotion and drawing and is_inside:
		current_line.add_point(mouse_pos)

func _on_close_button_pressed() -> void:
	self.visible = false
	get_tree().paused = false

func _on_submit_museum_pressed() -> void:
	var viewport = SubViewport.new()
	viewport.size = Vector2i(64, 64)
	viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	add_child(viewport)

	for child in get_children():
		if child is Line2D:
			var copy = child.duplicate()
			var rect = $ColorRect.get_rect()
			for i in copy.get_point_count():
				var p = copy.get_point_position(i)
				copy.set_point_position(i, (p - rect.position) / rect.size * Vector2(64, 64))
			viewport.add_child(copy)

	await RenderingServer.frame_post_draw
	var img = viewport.get_texture().get_image()
	img.resize(64, 64, Image.INTERPOLATE_BILINEAR)
	Gamemanager.player_drawing_one = ImageTexture.create_from_image(img)
	
	self.visible = false
	get_tree().paused = false
	viewport.queue_free()
	get_node("../../leave").visible = true
	
	# newspaper animation
	
