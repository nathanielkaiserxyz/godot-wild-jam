extends Area2D

var player_in_range: bool = false
var already_sold: bool = false
@export var drawing_screen_path: NodePath 

func _on_body_entered(body):
	if body.name == "Player": 
		player_in_range = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_range = false

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact") and !already_sold:
		already_sold = true
		open_drawing_screen()
	elif already_sold:
		pass
		#display 'I should get them back' or something

func open_drawing_screen():
	var ui = get_node("../CanvasLayer/Drawing_UI")
	ui.visible = true
	get_tree().paused = true 

func _on_leave_body_entered(_body: Node2D) -> void:
	if get_node("../leave").visible == true:
		Gamemanager.load_level(1)
		
func _on_close_paper_pressed() -> void:
	get_node("../newspaper").visible = false
