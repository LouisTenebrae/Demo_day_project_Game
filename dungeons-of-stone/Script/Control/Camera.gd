extends Camera2D

@onready var player = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera_panning()

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
