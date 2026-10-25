extends Sprite2D

var where = "night"
var speedy = 1.0
const BIG_SPEED = 64.0

const START_NIGHT = 2.1
const END_NIGHT = 3.7
const END_DAY = 6.2

func _ready() -> void:
	rotation = START_NIGHT
	where = "night"

func _process(delta: float) -> void:	
	rotate(delta * 0.01 * speedy)
	print(rotation)
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
