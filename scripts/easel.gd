extends Area2D

var player_in_range: bool = false
@export var drawing_screen_path: NodePath 

func _on_body_entered(body):
	if body.name == "Player": 
		player_in_range = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_range = false

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		open_drawing_screen()

func open_drawing_screen():
	var ui = get_node("../CanvasLayer/Drawing_UI")
	ui.visible = true
	get_tree().paused = true 
