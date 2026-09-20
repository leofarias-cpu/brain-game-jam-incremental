class_name Shop_Row extends Button

@export var upgrade: Upgrade
@export var title: RichTextLabel
@export var cost: RichTextLabel
@export var description: RichTextLabel
@export var icon2: TextureRect

@export var h_box_container: HBoxContainer

signal bought(upgrade: Upgrade)

func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSLATION_CHANGED:
		translate_text()

func _ready() -> void:
	cost.text = "$%s" % upgrade.get_next_upgrade_cost()
	cost.text = "$%s" % upgrade.get_next_upgrade_cost()
	
	if upgrade.icon:
		icon2.texture = upgrade.icon
	
	clamp_text_size()

func translate_text():
	title.text = tr(upgrade.resource_path.get_file().get_basename() + "_title")
	description.text = tr(upgrade.resource_path.get_file().get_basename() + "_description")



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
	AudioManager.play_sound(AudioManager.SOUND_EFFECTS.PURCHASED)

	if upgrade.current_upgrades == upgrade.max_upgrades:
		disable()
		cost.text = ":)"
		
		move_away()
	else:
		cost.text = "$" + str(upgrade.get_next_upgrade_cost())
		
	clamp_text_size()
	
func disable():
	self.disabled = true
	self.modulate = Color(0.337, 0.337, 0.337, 1.0)
	
func enable():
	self.disabled = false
	self.modulate = Color(1.0, 1.0, 1.0, 1.0)
	
func move_away():
	await get_tree().create_timer(1).timeout
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SPRING)
	var tweener := tween.tween_property(self, "offset_transform_position", Vector2(350, 0), 1)
	await tweener.finished
	visible = false
	offset_transform_position = Vector2(0, 0)

func clamp_text_size():
	if h_box_container.size.x > 260:
		title.add_theme_font_size_override("normal_font_size", 18)
		cost.add_theme_font_size_override("normal_font_size", 18)
	else:
		title.add_theme_font_size_override("normal_font_size", 22)
		cost.add_theme_font_size_override("normal_font_size", 22)
		
