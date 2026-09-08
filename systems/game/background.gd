class_name Background extends Sprite2D

var gradient: GradientTexture2D = self.texture

var flipped := false

func _on_game_go_crazy() -> void:
	var tween = get_tree().create_tween().set_parallel().set_trans(Tween.TRANS_SPRING)
	if flipped:
		tween.tween_property(gradient, "fill_from", Vector2(0, 0), 1)
		tween.tween_property(gradient, "fill_to", Vector2(1, 1), 1)
	else:
		tween.tween_property(gradient, "fill_from", Vector2(1, 1), 1)
		tween.tween_property(gradient, "fill_to", Vector2(0, 0), 1)
		
	flipped = not flipped
	
func reset_gradient() -> void:
	flipped = false
	
	var tween = get_tree().create_tween().set_parallel().set_trans(Tween.TRANS_SPRING)
	tween.tween_property(gradient, "fill_to", Vector2(1, 1), 1)
	tween.tween_property(gradient, "fill_from", Vector2(0, 0), 1)
