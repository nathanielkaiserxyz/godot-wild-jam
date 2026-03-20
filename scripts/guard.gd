extends CharacterBody2D

var run_speed = 100
var player = null

@onready var nav_agent = $NavigationAgent2D

func _physics_process(delta):
	if player:
		nav_agent.target_position = player.global_position
		
		if nav_agent.is_navigation_finished():
			return
			
		var next_point = nav_agent.get_next_path_position()
		velocity = global_position.direction_to(next_point) * run_speed
		move_and_slide()

func _on_detect_radius_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body

func _on_detect_radius_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player = null
