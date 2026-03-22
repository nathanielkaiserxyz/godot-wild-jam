extends CanvasLayer

@onready var rect = $"ColorRect"
var mat: ShaderMaterial

func _ready():
	print(rect)
	mat = rect.material
	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func iris_close(target_pos: Vector2, duration: float = 0.8):
	var viewport = get_viewport()
	var viewport_size = viewport.get_visible_rect().size
	
	var canvas_transform = viewport.get_canvas_transform()
	var screen_pos = canvas_transform * target_pos
	var uv = screen_pos / viewport_size
	
	mat.set_shader_parameter("center", uv)
	mat.set_shader_parameter("radius", 0.8)  # start smaller
	rect.visible = true
	
	var tween = create_tween()
	tween.tween_method(
		func(v): mat.set_shader_parameter("radius", v),
		0.8, 0.0, duration  # 0.8 -> 0.0
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	await tween.finished

func iris_open(duration: float = 0.8):
	mat.set_shader_parameter("radius", 0.0)
	
	var tween = create_tween()
	tween.tween_method(
		func(v): mat.set_shader_parameter("radius", v),
		0.0, 2.0, duration
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	await tween.finished
	rect.visible = false
