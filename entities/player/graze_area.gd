extends Area2D

@export var collision: CollisionShape2D

func _draw() -> void:
	draw_circle(Vector2.ZERO, collision.shape.radius, Color.WHITE, false, -1.0, false)
	self.modulate = Color.TRANSPARENT



func _on_area_entered(_area: Area2D) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, 'modulate', Color(0.431, 0.865, 0.51, 1.0), 0.2)
	tween.tween_property(self, 'modulate', Color(1.0, 1.0, 1.0, 0), 0.1)
