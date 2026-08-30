class_name UI extends CanvasLayer

@export var score_and_time_container: VBoxContainer
@export var money: RichTextLabel
@export var round_end_position: Marker2D
@export var shop: Panel
@export var timer: TimerLabel
@export var round_start_button: Button

func show_shop():
	await get_tree().create_timer(0.5).timeout
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_parallel()
	
	tween.tween_property(score_and_time_container, 'offset_transform_position', Vector2(-round_end_position.position.x - 40, 0), 0.5)
	
	tween.tween_property(money, 'offset_transform_position', Vector2(-round_end_position.position.x - 200, 0), 0.5)
	var money_scale = tween.tween_property(money, 'offset_transform_scale', Vector2(1.5, 1.5), 1)
	money_scale.finished.connect(func(): money.add_theme_font_size_override("normal_font_size", 24); money.offset_transform_scale = Vector2(1, 1))
	
	tween.tween_property(shop, 'offset_transform_position', Vector2(0, 0), 0.7)
	
	round_start_button.visible = true

func close_shop():
	await get_tree().create_timer(0.5).timeout
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_parallel()
	tween.tween_property(score_and_time_container, 'offset_transform_position', Vector2(0, 0), 0.5)
	
	tween.tween_property(money, 'offset_transform_position', Vector2(0, 0), 0.5)
	var money_scale = tween.tween_property(money, 'offset_transform_scale', Vector2(0.66, 0.66), 1)
	money_scale.finished.connect(func(): money.add_theme_font_size_override("normal_font_size", 16); money.offset_transform_scale = Vector2(1, 1))
	
	tween.tween_property(shop, 'offset_transform_position', Vector2(350, 0), 0.7)
	
	round_start_button.visible = false
	
	
func stop_timer():
	timer.stop()

func start_timer(duration: int):
	timer.start(duration)


func _on_game_money_set(value: int) -> void:
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_parallel()
	tween.tween_property(money, 'text', "$" + str(value), 1)
	
