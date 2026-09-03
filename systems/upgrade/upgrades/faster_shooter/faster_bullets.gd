extends Upgrade

func upgrade_effect():
	game.shooter_stats.bullet_stats.speed += 10
	game.shooter_stats.bullet_stats.graze_mult += 0.5
