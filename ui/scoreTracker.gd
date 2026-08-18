extends Label

var score = 0

func _on_player_graze() -> void:
	score += 1
	text = str(score)
