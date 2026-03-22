extends Node2D

var shader_material: ShaderMaterial
var player_in_range_of_sign: bool = false

#paintings
var player_in_range_of_painting_one: bool = false
var player_in_range_of_painting_clownfish: bool = false
var player_in_range_of_painting_fish_portrait: bool = false
var player_in_range_of_sword_fish_portrait: bool = false
var player_in_range_of_two_fish_portrait: bool = false
var player_in_range_of_moor_portrait: bool = false
var player_in_range_of_fish_painting_portrait: bool = false
var player_in_range_of_country_road: bool = false
var player_in_range_of_house_painting: bool = false
var player_in_range_of_still_life: bool = false
var player_in_range_of_boat: bool = false

var stolen_painting_scene = preload("res://scenes/mobs/stolen_painting.tscn")

func _ready() -> void:
	$player_painting/player_drawing.texture = Gamemanager.player_drawing_one
	shader_material = $player_painting_sign/Sprite2D.material
	await get_tree().physics_frame
	$NavigationRegion2D.bake_navigation_polygon()
	$Player/Player/Camera2D.zoom = Vector2(1.5, 1.5)
	$Player/Player/Camera2D.make_current()

func _process(_delta):
	if player_in_range_of_sign and Input.is_action_just_pressed("interact"):
		$player_painting_sign/player_sign.visible = true
		Gamemanager.player_movable = false
		
	if player_in_range_of_sign:
		$player_painting_sign/Sprite2D.material = shader_material
	else:
		$player_painting_sign/Sprite2D.material = null
	
	#STEALING PAINTINGS	
	if player_in_range_of_painting_one and Input.is_action_just_pressed("interact") and Gamemanager.first_time_in_museum:
		Gamemanager.player_movable = false
		Gamemanager.stolen_painting = true
	#second time in the museum
	elif player_in_range_of_painting_one and Input.is_action_just_pressed("interact") and Gamemanager.player_drawing_visible:
		$player_painting/player_drawing.visible = false
		Gamemanager.stolen_painting = true
		Gamemanager.player_drawing_visible = false
		var painting = stolen_painting_scene.instantiate()
		painting.setup($Player/Player)
		$Player/Player.add_child(painting)
	elif player_in_range_of_painting_clownfish and Input.is_action_just_pressed("interact") and !Gamemanager.first_time_in_museum and $Clownfish32x32.visible:
		$Clownfish32x32.visible = false
		Gamemanager.stolen_painting = true
		Gamemanager.player_clownfish_visible = false
		var painting = stolen_painting_scene.instantiate()
		painting.setup($Player/Player)
		$Player/Player.add_child(painting)
	elif player_in_range_of_painting_fish_portrait and Input.is_action_just_pressed("interact") and !Gamemanager.first_time_in_museum and $threeFishpotrait.visible:
		$threeFishpotrait.visible = false
		Gamemanager.stolen_painting = true
		Gamemanager.player_threefishportrait_visible = false
		var painting = stolen_painting_scene.instantiate()
		painting.setup($Player/Player)
		$Player/Player.add_child(painting)
	elif player_in_range_of_sword_fish_portrait and Input.is_action_just_pressed("interact") and !Gamemanager.first_time_in_museum and $Swordfishbiglandscape.visible:
		$Swordfishbiglandscape.visible = false
		Gamemanager.stolen_painting = true
		Gamemanager.player_swordfish_landscape_visible = false
		var painting = stolen_painting_scene.instantiate()
		painting.setup($Player/Player)
		$Player/Player.add_child(painting)
	elif player_in_range_of_two_fish_portrait and Input.is_action_just_pressed("interact") and !Gamemanager.first_time_in_museum and $Paintingfishtwo.visible:
		$Paintingfishtwo.visible = false
		Gamemanager.stolen_painting = true
		Gamemanager.player_two_fish_landscape_visible = false
		var painting = stolen_painting_scene.instantiate()
		painting.setup($Player/Player)
		$Player/Player.add_child(painting)
	elif player_in_range_of_moor_portrait and Input.is_action_just_pressed("interact") and !Gamemanager.first_time_in_museum and $moorishidol.visible:
		$moorishidol.visible = false
		Gamemanager.stolen_painting = true
		Gamemanager.player_moor_visible = false
		var painting = stolen_painting_scene.instantiate()
		painting.setup($Player/Player)
		$Player/Player.add_child(painting)
	elif player_in_range_of_fish_painting_portrait and Input.is_action_just_pressed("interact") and !Gamemanager.first_time_in_museum and $Fishpaintig1.visible:
		$Fishpaintig1.visible = false
		Gamemanager.stolen_painting = true
		Gamemanager.player_fish_painting_portrait_visible = false
		var painting = stolen_painting_scene.instantiate()
		painting.setup($Player/Player)
		$Player/Player.add_child(painting)
	elif player_in_range_of_country_road and Input.is_action_just_pressed("interact") and !Gamemanager.first_time_in_museum and $Nighttimecountryroad.visible:
		$Nighttimecountryroad.visible = false
		Gamemanager.stolen_painting = true
		Gamemanager.player_night_time_country_visible = false
		var painting = stolen_painting_scene.instantiate()
		painting.setup($Player/Player)
		$Player/Player.add_child(painting)		
	elif player_in_range_of_house_painting and Input.is_action_just_pressed("interact") and !Gamemanager.first_time_in_museum and $house_painting.visible:
		$house_painting.visible = false
		Gamemanager.stolen_painting = true
		Gamemanager.player_house_painting_visible = false
		var painting = stolen_painting_scene.instantiate()
		painting.setup($Player/Player)
		$Player/Player.add_child(painting)		
	elif player_in_range_of_still_life and Input.is_action_just_pressed("interact") and !Gamemanager.first_time_in_museum and $Stilllife.visible:
		$Stilllife.visible = false
		Gamemanager.stolen_painting = true
		Gamemanager.player_still_life_visible = false
		var painting = stolen_painting_scene.instantiate()
		painting.setup($Player/Player)
		$Player/Player.add_child(painting)		
	elif player_in_range_of_boat and Input.is_action_just_pressed("interact") and !Gamemanager.first_time_in_museum and $Boat.visible:
		$Boat.visible = false
		Gamemanager.stolen_painting = true
		Gamemanager.player_boat_visible = false
		var painting = stolen_painting_scene.instantiate()
		painting.setup($Player/Player)
		$Player/Player.add_child(painting)		
			
	if player_in_range_of_painting_one and !Gamemanager.stolen_painting:
		$player_painting/player_picture_frame.material = shader_material
		$player_painting/lettere.visible = true
	else:
		$player_painting/player_picture_frame.material = null
		$player_painting/lettere.visible = false

func _on_player_painting_sign_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_sign = true

func _on_player_painting_sign_body_exited(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_sign = false

func _on_button_pressed() -> void:
	$player_painting_sign/player_sign.visible = false
	Gamemanager.player_movable = true

func _on_player_painting_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_painting_one = true

func _on_player_painting_body_exited(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_painting_one = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !Gamemanager.top_left and body.name == "Player":
		var player = get_node("Player/Player")
		Gamemanager.player_movable = false
		await player.move_camera_to($top_left_cutscene)
		Gamemanager.top_left = true
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/gossipwhenpanstopainting.dialogue"), "start")
		await DialogueManager.dialogue_ended
		await player.move_camera_to($Player/Player)
		Gamemanager.player_movable = true


func _on_leave_body_entered(body: Node2D) -> void:
	if body.name == "Player" and !Gamemanager.player_drawing_visible:
		Gamemanager.load_level(7, $"Player/Player".global_position)


#PAINTINGS

func _on_clownfish_32x_32_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_painting_clownfish = true

func _on_clownfish_32x_32_body_exited(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_painting_clownfish = true

func _on_fishportrait_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_painting_fish_portrait = true

func _on_fishportrait_body_exited(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_painting_fish_portrait = false

func _on_swordfishlandscape_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_sword_fish_portrait = true

func _on_swordfishlandscape_body_exited(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_sword_fish_portrait = false

func _on_two_fish_painting_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_two_fish_portrait = true

func _on_two_fish_painting_body_exited(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_two_fish_portrait = true


func _on_moor_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_moor_portrait = true


func _on_moor_body_exited(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_moor_portrait = false


func _on_fish_painting_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_fish_painting_portrait = true


func _on_fish_painting_body_exited(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_fish_painting_portrait = false


func _on_countryroad_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_country_road = true

func _on_countryroad_body_exited(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_country_road = false


func _on_house_painting_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_house_painting = true

func _on_house_painting_body_exited(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_house_painting = false


func _on_still_life_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_still_life = true


func _on_still_life_body_exited(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_still_life = false


func _on_boat_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_boat = true


func _on_boat_body_exited(body: Node2D) -> void:
	if body.name == "Player": 
		player_in_range_of_boat = true
