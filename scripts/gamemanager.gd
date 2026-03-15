extends Node

var levels = [
	"res://scenes/level/art_reject.tscn",
	"res://scenes/level/world.tscn",
	"res://scenes/level/floor_two.tscn"
]

func load_level(index: int):
	if index < levels.size():
		get_tree().change_scene_to_file(levels[index])
	else:
		print("You beat the game!")
