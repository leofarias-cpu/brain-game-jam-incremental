extends Upgrade

func upgrade_effect():
	game.increase_play_space_size(32, 32)
	if current_upgrades == 1:
		game.add_upgrade(preload("uid://br6ratl7velv5"))
		game.add_upgrade(preload("uid://c5jbdn3d7l11q"))
	elif current_upgrades == 2:
		game.add_upgrade(preload("uid://c1gkakkt5gune"))
		# Arrow thing
		# PLayer speed
		
