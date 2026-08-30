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

	upgrades_container.add_child(row)
	upgrades.push_back(upgrade)
