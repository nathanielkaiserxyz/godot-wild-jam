extends Node



#player specific facts
@export var already_sold_painting_to_museum : bool = false
@export var player_movable: bool = true
@export var stolen_painting: bool = false
@export var first_time_in_museum: bool = true
@export var player_robber: bool = false


#paintings stolen status
@export var player_drawing_visible: bool = true


#scenes that get played once
@export var bottom_right: bool = false
@export var top_right: bool = false
@export var top_middle: bool = false
@export var top_left: bool = false
@export var bottom_left: bool = false


#drawings the player has made
var player_drawing_one: ImageTexture 

var levels = [
	"res://scenes/level/art_reject.tscn",
	"res://scenes/level/world.tscn",
	"res://scenes/level/floor_one.tscn",
	"res://scenes/level/floor_two.tscn",
	"res://scenes/level/options.tscn",
	"res://scenes/level/apartment2.tscn"
]

func load_level(index: int, from_position: Vector2 = Vector2.ZERO):
	if index < levels.size():
		Gamemanager.player_movable = false
		await SceneTransistion.iris_close(from_position)
		get_tree().call_deferred("change_scene_to_file", levels[index])
		await SceneTransistion.iris_open()
		Gamemanager.player_movable = true
