extends HBoxContainer


func _on_player_hit() -> void:
	var children = get_children()
	if children.is_empty():
		return
	children[0].queue_free()
