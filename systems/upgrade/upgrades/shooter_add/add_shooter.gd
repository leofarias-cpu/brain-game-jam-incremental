extends Upgrade

func upgrade_effect():
	game.add_enemy(preload("uid://xrywkkfs13"))
	game.add_upgrade(preload("uid://cgocwblblb08q")) # Faster bullets
	game.add_upgrade(preload("uid://bcx16oy0f484e")) # More bullets
	game.add_upgrade(preload("uid://blyfgfsmywy3q")) # More score
