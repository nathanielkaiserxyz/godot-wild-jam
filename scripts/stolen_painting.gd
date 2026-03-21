extends CharacterBody2D

@export var parent : CharacterBody2D

var speed = 40
var follow_point

func setup(p: CharacterBody2D):
	parent = p

func _ready():
	$AnimatedSprite2D.play("default")
	follow_point = parent.get_node("Marker2D")

func _physics_process(delta):
	var target = follow_point.global_position
	global_position = global_position.lerp(target, delta * 3.0) 
