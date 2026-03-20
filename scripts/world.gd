extends Node2D

func _on_leave_body_entered(_body: Node2D) -> void:	
	Gamemanager.load_level(2)
