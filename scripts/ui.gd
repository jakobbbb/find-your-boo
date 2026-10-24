extends Control

@onready var night = $Night

func set_night_day(is_night: bool) -> void:
	night.color.a = 1 if is_night else 0
