extends Upgrade

func upgrade_effect() -> void:
	game.remove_ball()
	game.add_enemy(preload("uid://lakuupc3ybdi"))
