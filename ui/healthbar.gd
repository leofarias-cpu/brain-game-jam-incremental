extends ProgressBar
@export var game: Game

func _ready() -> void:
	max_value = game.player_hp_max
	value = game.player_hp_max

func _on_player_hp_changed(v: int) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "value", v, 0.2)


func _on_game_hp_max_changed(v: int) -> void:
	max_value = v
