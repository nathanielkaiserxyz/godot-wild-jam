extends Node

@export var already_sold_painting_to_museum : bool = false
@export var player_movable: bool = true

var player_drawing_one: ImageTexture 

var levels = [
	"res://scenes/level/art_reject.tscn",
	"res://scenes/level/world.tscn",
	"res://scenes/level/floor_one.tscn",
	"res://scenes/level/floor_two.tscn",
	"res://scenes/level/options.tscn",
]

func load_level(index: int):
	if index < levels.size():
		get_tree().call_deferred("change_scene_to_file", levels[index])
