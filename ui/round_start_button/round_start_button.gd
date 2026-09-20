class_name RoundStartButton extends Button

@export var game: Game


func _on_pressed() -> void:
	game.round_start()
	AudioManager.play_sound(AudioManager.SOUND_EFFECTS.ROUND_START)



func _on_mouse_entered() -> void:
	var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SPRING)
	tween.parallel().tween_property(self, "offset_transform_scale", Vector2(1.3, 1.3), 0.1)
	
	tween.tween_property(self, "offset_transform_rotation", deg_to_rad(2), 0.1)
	tween.tween_property(self, "offset_transform_rotation", deg_to_rad(-2), 0.1)
	tween.tween_property(self, "offset_transform_rotation", deg_to_rad(0), 0.1)

func _on_mouse_exited() -> void:
	var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_parallel()
	tween.tween_property(self, "offset_transform_rotation", deg_to_rad(0), 0.1)
	tween.parallel().tween_property(self, "offset_transform_scale", Vector2(1, 1), 0.1)
	
