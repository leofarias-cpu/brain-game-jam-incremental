extends HBoxContainer


func _on_player_hit() -> void:
	get_children()[0].queue_free()
