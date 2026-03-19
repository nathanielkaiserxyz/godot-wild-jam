extends Area2D

var player_in_range: bool = false

func _ready() -> void:
	$AnimatedSprite2D.play("idle")

func _on_body_entered(body):
	if body.name == "Player": 
		player_in_range = true
		print("true")

func _on_body_exited(body):
	if body.name == "Player":
		player_in_range = false
		print("false")

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		Gamemanager.player_movable = false
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/guard_outside_museum.dialogue"), "start")
		await DialogueManager.dialogue_ended
		Gamemanager.player_movable = true
	
