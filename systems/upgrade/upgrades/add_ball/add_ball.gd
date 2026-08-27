extends Upgrade

func upgrade(game: Game) -> void:
	game.ball_stats.color = Color.REBECCA_PURPLE
	game.round_start()
