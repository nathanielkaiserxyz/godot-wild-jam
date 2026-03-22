extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	Gamemanager.load_level(0, $scene.global_position)
	$VBoxContainer/Start.disabled = true
	
func _on_options_pressed() -> void:
	Gamemanager.load_level(3)

func _on_quit_pressed() -> void:
	get_tree().quit()
