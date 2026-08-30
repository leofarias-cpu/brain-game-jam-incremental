class_name Shop_Row extends Button

@export var upgrade: Upgrade
@export var title: RichTextLabel
@export var cost: RichTextLabel
@export var description: RichTextLabel
@export var icon2: TextureRect

signal bought(upgrade: Upgrade)

func _ready() -> void:
	title.text = upgrade.title

		
	description.text = upgrade.description
	cost.text = "$%s" % upgrade.get_next_upgrade_cost()
	
	if upgrade.icon:
		icon2.texture = upgrade.icon


func _on_mouse_entered() -> void:
	if disabled:
		return
	var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING)
	tween.tween_property(self, "offset_transform_rotation", deg_to_rad(2), 0.1)
	tween.tween_property(self, "offset_transform_rotation", deg_to_rad(-2), 0.1)
	tween.tween_property(self, "offset_transform_rotation", deg_to_rad(0), 0.1)

func _on_mouse_exited() -> void:
	if disabled:
		return
	var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_parallel()
	tween.tween_property(self, "offset_transform_rotation", deg_to_rad(0), 0.1)

func _on_pressed() -> void:
	upgrade.upgrade()
	bought.emit(upgrade)
	
	if upgrade.current_upgrades == upgrade.max_upgrades:
		disable()
		cost.text = ":)"
		
		move_away()
	else:
		cost.text = "$" + str(upgrade.get_next_upgrade_cost())
	
func disable():
	self.disabled = true
	self.modulate = Color(0.337, 0.337, 0.337, 1.0)
	
func enable():
	self.disabled = false
	self.modulate = Color(1.0, 1.0, 1.0, 1.0)
	
func move_away():
	await get_tree().create_timer(3).timeout
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SPRING)
	var tweener := tween.tween_property(self, "offset_transform_position", Vector2(350, 0), 1)
	await tweener.finished
	visible = false
	offset_transform_position = Vector2(0, 0)
