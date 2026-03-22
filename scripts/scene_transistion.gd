extends CanvasLayer

@onready var rect = $ColorRect
var mat: ShaderMaterial

const PLAYER_WINDOW_PX = 20.0
const PAUSE_DURATION = 0.8

func _ready():
	mat = rect.material
	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	rect.visible = false

func _get_full_radius() -> float:
	var viewport_size = get_viewport().get_visible_rect().size
	var aspect = viewport_size.x / viewport_size.y
	return sqrt(1.0 + aspect * aspect)

func _px_to_uv_radius(px: float) -> float:
	var viewport_size = get_viewport().get_visible_rect().size
	return px / viewport_size.y

func iris_close(target_pos: Vector2 = Vector2.ZERO, duration: float = 0.8):
	var viewport = get_viewport()
	var viewport_size = viewport.get_visible_rect().size
	var canvas_transform = viewport.get_canvas_transform()

	var screen_pos = canvas_transform * target_pos
	var uv = screen_pos / viewport_size

	var full_radius = _get_full_radius()
	var window_radius = _px_to_uv_radius(PLAYER_WINDOW_PX)

	mat.set_shader_parameter("center", uv)
	mat.set_shader_parameter("radius", full_radius)
	rect.visible = true

	var tween = create_tween()
	tween.tween_method(
		func(v): mat.set_shader_parameter("radius", v),
		full_radius, window_radius, duration
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	await tween.finished

	await get_tree().create_timer(PAUSE_DURATION).timeout

	var tween_final = create_tween()
	tween_final.tween_method(
		func(v): mat.set_shader_parameter("radius", v),
		window_radius, 0.0, 0.25
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	await tween_final.finished

func iris_open(duration: float = .8):
	var full_radius = _get_full_radius()
	mat.set_shader_parameter("radius", 0.0)

	var tween = create_tween()
	tween.tween_method(
		func(v): mat.set_shader_parameter("radius", v),
		0.0, full_radius, duration
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	await tween.finished
	rect.visible = false
