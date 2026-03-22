extends Area2D
var player_in_range: bool = false
var shader_material: ShaderMaterial

func _ready() -> void:
	shader_material = $desk.material 

func _process(_delta: float) -> void:
	if player_in_range:
		$desk.material = shader_material
		$lettere.visible = true
	else:
		$desk.material = null
		$lettere.visible = false
	
	if player_in_range and Input.is_action_just_pressed("interact"):
		await SceneTransistion.iris_close($"../Player/Player".global_position)
		Gamemanager.player_robber = true
		await SceneTransistion.iris_open()
		Gamemanager.player_movable = false
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/guard_outside_museum.dialogue"), "start")
		await DialogueManager.dialogue_ended
		Gamemanager.player_movable = true

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range = true
	
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false

	
