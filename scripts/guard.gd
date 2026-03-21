extends CharacterBody2D

var player = null
var run_speed = 100.0
var patrol_speed = 30.0

@onready var path_follow = $Path2D/PathFollow2D
@onready var nav_agent = $NavigationAgent2D
var update_path_timer := 0.0

func _ready():
	await get_tree().physics_frame
	await get_tree().physics_frame
	nav_agent.radius = 8.0
	nav_agent.path_desired_distance = 4.0
	nav_agent.target_desired_distance = 4.0
	nav_agent.avoidance_enabled = true

func _physics_process(delta):
	if player and Gamemanager.stolen_painting:
		update_path_timer -= delta
		if update_path_timer <= 0.0:
			nav_agent.target_position = player.global_position
			update_path_timer = 0.2
		if nav_agent.is_navigation_finished():
			move_and_slide()
			return
		var next_point = nav_agent.get_next_path_position()
		velocity = global_position.direction_to(next_point) * run_speed
	else:
		# Move the PathFollow2D progress forward
		path_follow.progress += patrol_speed * delta
		# Move enemy toward the PathFollow2D's position
		var target = path_follow.global_position
		velocity = global_position.direction_to(target) * patrol_speed
	
	move_and_slide()


func _on_detect_radius_body_entered(body: Node2D) -> void:
	if body.name == "Player" and Gamemanager.stolen_painting:
		player = body
		$exclamation.visible = true
		$Timer.start()
		await $Timer.timeout
		$exclamation.visible = false
		

func _on_detect_radius_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player = null
