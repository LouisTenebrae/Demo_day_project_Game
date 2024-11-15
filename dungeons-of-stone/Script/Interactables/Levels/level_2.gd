extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_tower_2_skel_child_exiting_tree(node: Node) -> void:
	if $Tower2Skel.child_exiting_tree:
		get_tree().change_scene_to_file.bind("res://Scenes/Levels/epilogue_node.tscn").call_deferred()
