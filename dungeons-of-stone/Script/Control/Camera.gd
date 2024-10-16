extends Camera2D

@onready var player = $"../Player"
@export var camera: camera_state
enum camera_state {FOLLOW,PANNING}

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../Player")
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player:  
		global_position = player.global_position

func camera_panning():
	anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	position = player.position
	var x = floor(position.x / 320) * 320
	var y = floor(position.y / 180) * 180

	position = Vector2(x,y)

	var tweening := create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tweening.tween_property(self, "position", Vector2(x,y), 0.14)

func camera_follow():
	anchor_mode = Camera2D.ANCHOR_MODE_DRAG_CENTER
	position = player.position
	
