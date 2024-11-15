extends CanvasLayer

const HEART_ROW_SIZE = 8
const HEART_OFFSET = 16

@export var max_hearts = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(4):
		var new_heart = Sprite2D.new()
		new_heart.texture = $Life.texture
		new_heart.hframes = $Life.hframes
		new_heart.frame = 0
		$Life.add_child(new_heart)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	display_hearts()

func display_hearts():
	# Loop from the last heart (rightmost) to the first (leftmost)
	for index in range(max_hearts - 1, -1, -1):  # Start from max_hearts - 1, go to 0, decrement by 1
		var heart = $Life.get_child(index)
		var x = ((max_hearts - 1 - index) % HEART_ROW_SIZE) * HEART_OFFSET  # Calculate X position, reversed
		heart.position = Vector2(x, 0)
		
		# Set heart frame from right to left based on life
		if index < floor(player_data.life):  # Full heart
			heart.frame = 4
		elif index == floor(player_data.life):  # Partial heart
			heart.frame = int((player_data.life - index) * 4)
		else:  # Empty heart
			heart.frame = 0
