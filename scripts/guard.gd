extends CharacterBody2D

var player = null
var run_speed = 100.0
var patrol_speed = 30.0

@onready var nav_agent = $NavigationAgent2D
@onready var animate = $AnimatedSprite2D
var update_path_timer := 0.0

var patrol_counter = 0
var patrol: Array = []
var patrol_waiting := false

func _ready():
	await get_tree().physics_frame
	await get_tree().physics_frame
	nav_agent.radius = 8.0
	nav_agent.path_desired_distance = 4.0
	nav_agent.target_desired_distance = 4.0
	nav_agent.avoidance_enabled = true
	
	patrol = [
		get_node("../../patrol").global_position,
		get_node("../../patrol2").global_position,
		get_node("../../patrol3").global_position,
		get_node("../../patrol4").global_position
	]
	await get_tree().physics_frame
	$Area2D.body_entered.connect(_on_area_2d_body_entered)

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
		if patrol.is_empty() or patrol_waiting:
			return
		update_path_timer -= delta
		if update_path_timer <= 0.0:
			nav_agent.target_position = patrol[patrol_counter]
			update_path_timer = 0.2
		if global_position.distance_to(patrol[patrol_counter]) < 15.0:
			patrol_waiting = true
			_next_patrol_point()
			return
		var next_point = nav_agent.get_next_path_position()
		velocity = global_position.direction_to(next_point) * patrol_speed
	move_and_slide()
	
	var direction = velocity.normalized()
	if direction != Vector2.ZERO:
			if abs(direction.x) > abs(direction.y):
				animate.play("run")

				if direction.x > 0:
					animate.flip_h = false
				else:
					animate.flip_h = true

			else:
				if direction.y > 0:
					animate.play("done")
				else:
					animate.play("up")
	else:
		animate.play("idle")

func _next_patrol_point():
	await get_tree().create_timer(1.0).timeout
	if patrol_counter < 3:
		print("next_stop")
		patrol_counter += 1
	else:
		patrol_counter = 0
	patrol_waiting = false

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

func _on_area_2d_body_entered(body: Node2D) -> void:
	if Gamemanager.first_time_in_museum:
		Gamemanager.player_movable = false
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/caught_in_museum_first_time.dialogue"), "start")
		await DialogueManager.dialogue_ended
		Gamemanager.load_level(5, $"../../Player/Player".global_position)
	elif Gamemanager.stolen_painting:
		Gamemanager.player_movable = false
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/youre_going_to_jail.dialogue"), "start")
		await DialogueManager.dialogue_ended
		#load Jail level
		#Gamemanager.load_level(5, $"../../Player/Player".global_position)
