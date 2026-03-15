extends CharacterBody2D

@export var speed: float = 300.0
@export var dash_speed: float = 900.0
@export var dash_duration: float = 0.2

var is_dashing: bool = false
var dash_direction: Vector2 = Vector2.ZERO
@onready var player = $AnimatedSprite2D 

func _physics_process(delta):
	if is_dashing:
		velocity = dash_direction * dash_speed
	else:
		var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		velocity = direction * speed

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

		if Input.is_action_just_pressed("ui_select") and direction != Vector2.ZERO:
			start_dash(direction)

	move_and_slide()

func start_dash(dir):
	is_dashing = true
	dash_direction = dir
	
	await get_tree().create_timer(dash_duration).timeout
	is_dashing = false
