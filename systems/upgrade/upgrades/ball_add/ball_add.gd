extends Upgrade

func upgrade_effect() -> void:
	game.add_enemy(preload("uid://cuovppwi20kvk"))
	game.ball_stats.graze += 1
