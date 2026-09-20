extends ProgressBar
@export var game: Game
var dir := 1
func _ready() -> void:
	max_value = game.player_hp_max
	value = game.player_hp_max

func _on_player_hp_changed(v: int) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "value", v, 0.2)
	
	dir *= -1
	tween.parallel().tween_property(self, "offset_transform_rotation", deg_to_rad(3 * dir), 0.1)
	tween.tween_property(self, "offset_transform_rotation", deg_to_rad(-3 * dir), 0.1)
	tween.tween_property(self, "offset_transform_rotation", deg_to_rad(0), 0.1)


func _on_game_hp_max_changed(v: int) -> void:
	max_value = v
