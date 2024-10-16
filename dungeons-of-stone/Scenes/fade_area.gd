extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var parent = self.get_parent()
		if parent:
			parent.modulate.a = 0.1



func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		var parent = self.get_parent()
		if parent:
			parent.modulate.a = 1
