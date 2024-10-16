extends Camera2D


func _process(delta):
	var player_position = get_parent().position
	position = lerp(position, player_position, 0.1)
