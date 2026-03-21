extends CharacterBody2D

var run_speed = 50
var player = null
var update_path_timer := 0.0
@onready var nav_agent = $NavigationAgent2D

func _ready():
	await get_tree().physics_frame
	await get_tree().physics_frame
	nav_agent.radius = 8.0
	nav_agent.path_desired_distance = 4.0
	nav_agent.target_desired_distance = 4.0
	nav_agent.avoidance_enabled = true
	nav_agent.path_postprocessing = NavigationPathQueryParameters2D.PATH_POSTPROCESSING_EDGECENTERED

func _physics_process(delta):
	if player:
		update_path_timer -= delta
		if update_path_timer <= 0.0:
			nav_agent.target_position = player.global_position
			update_path_timer = 0.2

		if nav_agent.is_navigation_finished():
			return

		var next_point = nav_agent.get_next_path_position()
		velocity = global_position.direction_to(next_point) * run_speed
		move_and_slide()

func _on_detect_radius_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		$exclamation.visible = true
		$Timer.start()
		await $Timer.timeout
		$exclamation.visible = false
		

func _on_detect_radius_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player = null
