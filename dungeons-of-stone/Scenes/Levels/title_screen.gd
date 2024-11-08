extends Control


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/Level.tscn")
	
	


func _on_quit_button_pressed() -> void:
	get_tree().quit()
	


func _on_settings_button_pressed():
	$StartButton.visible = false
	$SettingsButton.visible = false
	$QuitButton.visible = false
	$"Pixil-frame-0(2)".visible = false
	$SettingsMenu.visible = true
