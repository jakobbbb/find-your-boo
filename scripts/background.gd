extends Sprite2D

var where = "night"
var speedy = 1.0
const BIG_SPEED = 16.0

const START_NIGHT = 1.6
const END_NIGHT = 4.6
const START_DAY = 5.5
const END_DAY = 6.5

func _ready() -> void:
	rotation = START_NIGHT
	where = "night"

func _process(delta: float) -> void:	
	rotate(delta * 0.01 * speedy)
	if rotation >= 2 * PI:
		rotation -= 2 * PI
		
	if speedy == BIG_SPEED and where == "night" and (rotation >= START_NIGHT and rotation < END_DAY):
		print("ending speed")
		print("  rot ", rotation)
		var tw = create_tween()
		tw.tween_property(self, "speedy", 1.0, 1.0)

func _yarn_command_rotate(w: String) -> void:
	where = w
	if where == "night":
		rotation = END_DAY
		speedy = BIG_SPEED
		print("starting speed")
