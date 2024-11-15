extends Control

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Scenes/Levels/title_screen.tscn")
