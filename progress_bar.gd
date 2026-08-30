extends TextureProgressBar


func _on_going_crazy_timer_timeout() -> void:
	value = 0
	tint_under = Color.FIREBRICK
	tint_progress = Color.FIREBRICK
