class_name Shop extends Panel

@export var initial_upgrades: Array[Upgrade] 
@export var upgrades: Array[Upgrade] 
@export var upgrades_container: VBoxContainer

@export var shop_row: PackedScene
@export var game: Game

func _ready() -> void:
	for upgrade in initial_upgrades:
		add_upgrade(upgrade)

func add_upgrade(upgrade: Upgrade):
	if upgrades.has(upgrade): return
	
	upgrade.game = game

	var row: Shop_Row = shop_row.instantiate()
	row.upgrade = upgrade
	row.bought.connect(on_upgrade_bought)
	
	upgrades_container.add_child(row)
	#row.move_away()
	upgrades.push_back(upgrade)

func disable_expensive_upgrades():
	for upgrade: Shop_Row in upgrades_container.get_children():
		if upgrade.upgrade.get_next_upgrade_cost() > game.money:
			upgrade.disable()
		else:
			upgrade.enable()

func on_upgrade_bought(_upgrade: Upgrade):
	disable_expensive_upgrades()
