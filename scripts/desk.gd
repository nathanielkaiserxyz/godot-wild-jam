extends Area2D
var player_in_range: bool = false
var shader_material: ShaderMaterial

func _ready() -> void:
	shader_material = $desk.material 
	Gamemanager.player_movable = false
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/back_in_the_apartment.dialogue"), "start")
	Gamemanager.player_movable = true
	Gamemanager.stolen_painting = false
	Gamemanager.first_time_in_museum = false
	
func _process(_delta: float) -> void:
	if player_in_range:
		$desk.material = shader_material
		$lettere.visible = true
	else:
		$desk.material = null
		$lettere.visible = false
	
	if player_in_range and Input.is_action_just_pressed("interact"):
		Gamemanager.player_movable = false
		$"../leave".visible = true
		await SceneTransistion.iris_close($"../Player/Player".global_position)
		Gamemanager.player_robber = true
		await SceneTransistion.iris_open()
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/changedintorobberoutfit.dialogue"), "start")
		await DialogueManager.dialogue_ended
		Gamemanager.player_movable = true
		

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range = true
	
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false

func _on_leave_body_entered(body: Node2D) -> void:
	if get_node("../leave").visible == true:
		Gamemanager.load_level(1, $"../Player/Player".global_position)
