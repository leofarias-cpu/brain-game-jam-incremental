extends Upgrade

func upgrade_effect():
	game.increase_play_space_size(32, 32)
	
	if current_upgrades == 1:
		game.add_upgrade(preload("uid://br6ratl7velv5")) # Evil ball
		game.add_upgrade(preload("uid://c5jbdn3d7l11q")) # More hp
		
	elif current_upgrades == 2:
		game.add_upgrade(preload("uid://c1gkakkt5gune")) # Shooter
		game.add_upgrade(preload("uid://tcq3q6p7p52")) # Speed
		game.add_upgrade(preload("uid://dt0wpt0qb18or")) # King grazing
