extends Node2D

var shader_material: ShaderMaterial
var player_in_range: bool = false

func _ready() -> void:
	$player_painting/player_drawing.texture = Gamemanager.player_drawing_one
	shader_material = $player_painting_sign/Sprite2D.material
	await get_tree().physics_frame
	$NavigationRegion2D.bake_navigation_polygon()
	
func _process(_delta):	
	if player_in_range:
		$player_painting_sign/Sprite2D.material = shader_material
	else:
		$player_painting_sign/Sprite2D.material = null


func _on_player_painting_sign_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range = true


func _on_player_painting_sign_body_exited(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range = false
