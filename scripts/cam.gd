extends Camera2D

@onready var dia: YarnDialogueRunner = %YarnDialogueRunner

const TRANSITION_DURATION_SECONDS = 0.45

var is_interpolating = false
var pos_original: Vector2
var zoom_original: Vector2
var transitioning: Camera2D
var interp_timer = 0.0

func _ready() -> void:
	pos_original = transform.origin
	zoom_original = zoom

func _process(delta: float) -> void:
	if not is_interpolating:
		return
	
	var t = interp_timer / TRANSITION_DURATION_SECONDS
	if t > 1.0:
		t = 1.0
	
	var a = transitioning.pos_original
	var b = pos_original
	transitioning.position = a.lerp(b, t)
	
	var x = transitioning.zoom_original
	var y = zoom_original
	transitioning.zoom = x.lerp(y, t)
	
	interp_timer += delta
	if interp_timer >= TRANSITION_DURATION_SECONDS:
		is_interpolating = false
		interp_timer = 0.0
		make_current()
		transitioning.reset_prelerp()
		transitioning = null

func reset_prelerp() -> void:
	transform.origin = pos_original
	zoom = zoom_original

func make_current_smooth() -> void:
	transitioning = get_viewport().get_camera_2d()
	is_interpolating = true

func _on_arrow_pressed() -> void:
	if not dia.is_running():
		make_current_smooth()

func _yarn_command_cam() -> void:
	make_current()
