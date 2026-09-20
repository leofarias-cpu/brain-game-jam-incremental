extends TextureProgressBar


func _on_going_crazy_timer_timeout() -> void:
	value = 0
	tint_under = Color.FIREBRICK
	tint_progress = Color.FIREBRICK

func reset():
	value = 0
	tint_under = Color.WHITE
	tint_progress = Color.WHITE
