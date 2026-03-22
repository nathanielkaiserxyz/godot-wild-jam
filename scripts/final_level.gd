extends Area2D

var player_in_range: bool = false
var already_sold: bool = false
@export var drawing_screen_path: NodePath 
var shader_material: ShaderMaterial

func _ready():
	shader_material = $easel.material
	$"../Player/Player/Camera2D".zoom = Vector2(.8, .8)
	$"../player_frame/player_art".texture = Gamemanager.player_drawing_one
	if !Gamemanager.player_clownfish_visible:
		$"../clownfish32x32".visible = true
	if !Gamemanager.player_threefishportrait_visible:
		$"../threefishportrait".visible = true
	if !Gamemanager.player_swordfish_landscape_visible:
		$"../swordfish".visible = true
	if !Gamemanager.player_two_fish_landscape_visible:
		$"../twofishportrait".visible = true
	if !Gamemanager.player_moor_visible:
		$"../moor".visible = true
	if !Gamemanager.player_fish_painting_portrait_visible:
		$"../painting_portrait".visible = true
	if !Gamemanager.player_night_time_country_visible:
		$"../country_road".visible = true
	if !Gamemanager.player_house_painting_visible:
		$"../house_painting".visible = true	
	if !Gamemanager.player_still_life_visible:
		$"../still_life".visible = true	
	if !Gamemanager.player_boat_visible:
		$"../boat".visible = true	

func _on_body_entered(body):
	if body.name == "Player": 
		player_in_range = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_range = false

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact") and !already_sold:
		open_drawing_screen()
	elif already_sold:
		pass
		#display 'I should get them back' or something]
	if player_in_range:
		$easel.material = shader_material
		$lettere.visible = true
	else:
		$easel.material = null
		$lettere.visible = false
			

func open_drawing_screen():
	var ui = get_node("../CanvasLayer/Drawing_UI")
	ui.visible = true
	get_tree().paused = true 
