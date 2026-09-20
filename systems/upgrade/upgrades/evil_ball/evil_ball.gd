extends Upgrade

func upgrade_effect() -> void:
	game.remove_ball()
	game.add_enemy(preload("uid://lakuupc3ybdi"))
	game.add_upgrade(preload("uid://dt0wpt0qb18or")) # King grazing
