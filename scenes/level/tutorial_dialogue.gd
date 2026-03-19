extends Area2D

func _on_body_entered(_body: Node2D) -> void:	
	Gamemanager.player_movable = false
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/first-room.dialogue"), "start")
	await DialogueManager.dialogue_ended
	Gamemanager.player_movable = true
