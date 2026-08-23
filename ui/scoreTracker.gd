extends Label

var score = 0

func _on_player_graze(value: int) -> void:
	score += value
	text = str(score)
