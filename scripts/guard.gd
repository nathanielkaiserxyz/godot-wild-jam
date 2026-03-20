extends CharacterBody2D

var run_speed = 25
var player = null

func _physics_process(delta):
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * run_speed
	move_and_slide()

func _on_detect_radius_body_entered(body: Node2D) -> void:
	player = body
	print("check")
	
func _on_detect_radius_body_exited(body: Node2D) -> void:
	player = null
	print("uncheck")
