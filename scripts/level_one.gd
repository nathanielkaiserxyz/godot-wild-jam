extends Node2D

var shader_material: ShaderMaterial
var player_in_range_of_sign: bool = false
var player_in_range_of_painting_one: bool = false
var stolen_painting_scene = preload("res://scenes/mobs/stolen_painting.tscn")

func _ready() -> void:
	print("ready started")
	$player_painting/player_drawing.texture = Gamemanager.player_drawing_one
	print("texture set")
	shader_material = $player_painting_sign/Sprite2D.material
	print("shader set")
	await get_tree().physics_frame
	print("after physics frame")
	$NavigationRegion2D.bake_navigation_polygon()
	print("nav baked")
	$Player/Player/Camera2D.zoom = Vector2(1.5, 1.5)
	print("zoom set")
	$Player/Player/Camera2D.make_current()
	print("camera global pos: ", $Player/Player/Camera2D.global_position)
	print("player global pos: ", $Player/Player.global_position)
	
func _process(_delta):
	if player_in_range_of_sign and Input.is_action_just_pressed("interact"):
		$player_painting_sign/player_sign.visible = true
		Gamemanager.player_movable = false
	if player_in_range_of_sign:
		$player_painting_sign/Sprite2D.material = shader_material
	else:
		$player_painting_sign/Sprite2D.material = null
	
	if player_in_range_of_painting_one and Input.is_action_just_pressed("interact"):
		$player_painting/player_drawing.visible = false
		Gamemanager.stolen_painting = true
		var painting = stolen_painting_scene.instantiate()
		painting.setup($Player/Player)
		$Player/Player.add_child(painting)
		
	if player_in_range_of_painting_one and !Gamemanager.stolen_painting:
		$player_painting/player_picture_frame.material = shader_material
		$player_painting/lettere.visible = true
	else:
		$player_painting/player_picture_frame.material = null
		$player_painting/lettere.visible = false

func _on_player_painting_sign_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_sign = true

func _on_player_painting_sign_body_exited(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_sign = false

func _on_button_pressed() -> void:
	$player_painting_sign/player_sign.visible = false
	Gamemanager.player_movable = true

func _on_player_painting_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_painting_one = true

func _on_player_painting_body_exited(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_painting_one = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !Gamemanager.top_left and body.name == "Player":
		var player = get_node("Player/Player")
		player.move_camera_to($top_left_cutscene)
