class_name Shop_Row extends Button

@export var upgrade: Upgrade
@export var title: RichTextLabel
@export var cost: RichTextLabel
@export var description: RichTextLabel
@export var icon2: TextureRect

func _ready() -> void:
	title.text = upgrade.title
	if upgrade.current_upgrades > 0:
		title.text += " +%s" % upgrade.current_upgrades
		
	description.text = upgrade.description
	cost.text = "$%s" % upgrade.get_next_upgrade_cost()
	
	if upgrade.icon:
		icon2.texture = upgrade.icon


func _on_mouse_entered() -> void:
	var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING)
	tween.tween_property(self, "offset_transform_rotation", deg_to_rad(2), 0.1)
	tween.tween_property(self, "offset_transform_rotation", deg_to_rad(-2), 0.1)
	tween.tween_property(self, "offset_transform_rotation", deg_to_rad(0), 0.1)

func _on_mouse_exited() -> void:
	var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_parallel()
	tween.tween_property(self, "offset_transform_rotation", deg_to_rad(0), 0.1)


func _on_pressed() -> void:
	upgrade.upgrade()
	cost.text = "$" + str(upgrade.get_next_upgrade_cost())
