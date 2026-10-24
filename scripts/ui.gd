extends Control

@onready var night = $Night


func _ready() -> void:
	GameManager.set_night.connect(_on_set_night)
	GameManager.set_day.connect(_on_set_day)

func set_night_day(is_night: bool) -> void:
	night.color.a = 1 if is_night else 0


func _on_set_day() -> void:
	set_night_day(false)


func _on_set_night() -> void:
	print("ui: Good night")
	set_night_day(true)
