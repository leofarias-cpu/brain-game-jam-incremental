extends Upgrade

func upgrade(game: Game):
	game.ball_stats.speed += 10
	game.ball_stats.graze_mult *= 1.5
