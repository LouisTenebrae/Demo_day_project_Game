extends Label


func _ready() -> void:
	update_level()


func _process(delta: float) -> void:
	update_level()

func update_level():
	text="Level: " + str(Global.player_level)
