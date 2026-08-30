## This is actually abstract so plase override upgrade, thanks.
## Since you can't make resources out of abstract resource this can't actually be a resource affff
class_name Upgrade extends Resource

@export var cost_curve: Curve
## Amount of times this can be upgraded.
@export var max_upgrades: int = 1
var current_upgrades: int = 0

@export var title: String = "Heheheheheeh"
@export var description: String = "Buy me B )"
@export var icon: Texture2D = preload("uid://4q335xxs2p")

var game: Game

## Does general upgrade things and calls the upgrade_effect inheritors must implement.
func upgrade() -> void:
	game.money -= get_next_upgrade_cost()
	current_upgrades += 1
	upgrade_effect()

func get_next_upgrade_cost() -> int:
	return int(cost_curve.sample(current_upgrades + 1))
	
## Override this please.
## Applies the effect of the upgrade by modifying Game.
## Could be adding an enemy, changing stats, anything.
func upgrade_effect():
	pass
