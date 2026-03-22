extends Node2D

func ready():
	pass
	
func _on_leave_body_entered(_body: Node2D) -> void:	
	Gamemanager.load_level(2, $Player/Player.global_position)
