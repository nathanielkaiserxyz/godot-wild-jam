extends CharacterBody2D

@export var speed: float = 75.0
@export var dash_speed: float = 180.0
@export var dash_duration: float = 0.2

var is_dashing: bool = false
var dash_direction: Vector2 = Vector2.ZERO

var previous_position: Vector2 = Vector2.ZERO
@onready var marker = $Marker2D
@onready var player = $AnimatedSprite2D 
@onready var camera = $Camera2D


func _ready():
	previous_position = global_position
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = .3
	timer.autostart = true
	timer.timeout.connect(_update_marker)
	timer.start()

func _update_marker():
	var direction_to_player = global_position - previous_position
	
	if direction_to_player.length() < 1.0:
		marker.global_position = global_position + Vector2(0, 20)
	else:
		var offset = direction_to_player.normalized() * -20
		marker.global_position = global_position + offset
		previous_position = global_position
	
	previous_position = global_position

func _physics_process(_delta):
	if is_dashing:
		velocity = dash_direction * dash_speed
	else:
		var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		if Gamemanager.player_movable == true:	
			velocity = direction * speed
		else:
			velocity = direction * 0
		
		if direction != Vector2.ZERO:
			if abs(direction.x) > abs(direction.y):
				player.play("run")

				if direction.x > 0:
					player.flip_h = false
				else:
					player.flip_h = true

			else:
				if direction.y > 0:
					player.play("done")
				else:
					player.play("up")
		else:
			player.play("idle")

		if Input.is_action_just_pressed("ui_select") and direction != Vector2.ZERO and Gamemanager.player_movable == true:
			start_dash(direction)

	move_and_slide()

func start_dash(dir):
	is_dashing = true
	dash_direction = dir

	if abs(dir.x) > abs(dir.y):
		player.play("flip_sideways")
		player.flip_h = dir.x <= 0
	else:
		if dir.y > 0:
			player.play("flip_down")
		else:
			player.play("flip_up")
			
	await player.animation_finished
	is_dashing = false

var is_transitioning = false

func move_camera_to(target: Node2D, duration: float = 5.0):
	is_transitioning = true
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(camera, "global_position", target.global_position, duration)
	
	await tween.finished
	is_transitioning = false

func return_camera(duration: float = 1.0):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	# target local position zero = back on top of player
	tween.tween_property(camera, "position", Vector2.ZERO, duration)
	
	await tween.finished
