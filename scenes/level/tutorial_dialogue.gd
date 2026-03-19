extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("dia")
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/first-room.dialogue"), "start")
