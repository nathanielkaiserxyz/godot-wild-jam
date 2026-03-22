extends Area2D

var player_in_range: bool = false
var player_in_dialogue: bool = false
var shader_material: ShaderMaterial

func _ready() -> void:
	shader_material = $AnimatedSprite2D.material
	$AnimatedSprite2D.play("idle")

func _on_body_entered(body):
	if body.name == "Player": 
		player_in_range = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_range = false

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact") and !player_in_dialogue:
		Gamemanager.player_movable = false
		player_in_dialogue = true
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/guard_outside_museum.dialogue"), "start")
		await DialogueManager.dialogue_ended
		player_in_dialogue = false
		Gamemanager.player_movable = true
	
	if player_in_range:
		$AnimatedSprite2D.material = shader_material
	else:
		$AnimatedSprite2D.material = null
