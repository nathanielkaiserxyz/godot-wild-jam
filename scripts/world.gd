extends Node2D

func ready():
	pass
	#await SceneTransistion.iris_open(10)

func _on_leave_body_entered(_body: Node2D) -> void:	
	#await SceneTransistion.iris_close($Player/Player.global_position, .8)
	Gamemanager.load_level(2)
