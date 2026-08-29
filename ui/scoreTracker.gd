extends RichTextLabel



func _on_game_score_set(value: int) -> void:
	self.text = str(value)
