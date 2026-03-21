extends Area2D
var player_in_range: bool = false
var shader_material: ShaderMaterial
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shader_material = $desk.material 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	if player_in_range:
		$desk.material = shader_material
		$lettere.visible = true
	else:
		$desk.material = null
		$lettere.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range = true
	
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false

	
