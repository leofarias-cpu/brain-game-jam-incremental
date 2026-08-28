class_name Background extends Sprite2D

var gradient: GradientTexture2D = self.texture


func _on_game_go_crazy() -> void:
	var tween = get_tree().create_tween().set_parallel().set_trans(Tween.TRANS_SPRING)
	tween.tween_property(gradient, "fill_from", Vector2(1, 1), 1)
	tween.tween_property(gradient, "fill_to", Vector2(0, 0), 1)
	#gradient.gradient.set_color(1, Color.WHITE_SMOKE)

func reset_gradient() -> void:
	var tween = get_tree().create_tween().set_parallel().set_trans(Tween.TRANS_SPRING)
	tween.tween_property(gradient, "fill_to", Vector2(1, 1), 1)
	tween.tween_property(gradient, "fill_from", Vector2(0, 0), 1)
