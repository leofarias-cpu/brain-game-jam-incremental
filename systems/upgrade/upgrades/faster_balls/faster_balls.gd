extends Upgrade

func upgrade_effect():
	game.ball_stats.speed += 10
	game.ball_stats.graze_mult += 0.5
