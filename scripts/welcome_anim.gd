extends Control

const TIMEOUT = 2
var timer = 0
var timer_active = false

func _ready() -> void:
	$ColorRect.visible = true
	$AnimationPlayer.play("intro_fade_in")
	
func _on_pressed() -> void:
	$AnimationPlayer.play_backwards("intro_fade_in")
	timer_active = true
	
func _process(delta: float) -> void:
	if timer_active:
		timer += delta
		if timer >= TIMEOUT:
			get_tree().change_scene_to_file("res://test.tscn")
