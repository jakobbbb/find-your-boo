extends AudioStreamPlayer

const THEME_FADE_DURATION_SECONDS = 0.5
const MAIN_THEME = "res://audio/Themes/Boo_Main_Theme.wav"
const CHARACTER_THEMES = {
	"fish": "res://audio/Themes/Jaws_Theme.wav",
	"moth": "res://audio/Themes/NighmareOnElmStreet_Theme.wav",
	"mum": "res://audio/Themes/Freitag13_Theme.wav",
	"drac": "res://audio/Themes/Halloween_Theme.wav",
	"witch": "res://audio/Themes/Exorzist_Theme.wav",
}

# resource path -> loaded stream
var themes = {}
var current_theme = "main"

func _ready() -> void:
	for theme in [MAIN_THEME] + CHARACTER_THEMES.values():
		themes[theme] = load(theme)
	
	stream = themes[MAIN_THEME]
	volume_linear = 0
	play()
	fade(true, create_tween())
	
	GameManager.play_theme.connect(play_character_theme)
	

func fade(fade_in: bool, tween) -> Tween:
	var volume = int(fade_in)
	tween.tween_property(self, "volume_linear", volume, THEME_FADE_DURATION_SECONDS)
	return tween

func play_character_theme(cname: String) -> void:
	
	if current_theme == cname:
		return  # dont re-start existing theme
	current_theme = cname
	
	var tween = fade(false, create_tween())
	
	var lambda = func():
		stop()
		var theme_path = MAIN_THEME  # default
		if cname != "main":
			theme_path = CHARACTER_THEMES[cname]
		stream = themes[theme_path]
		play()
	tween.tween_callback(lambda)
	fade(true, tween)
