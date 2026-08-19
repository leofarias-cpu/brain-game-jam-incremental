class_name PlaySpace
extends Sprite2D

@export var border: Sprite2D
@onready var left: CollisionShape2D = $StaticBody2D/Left
@onready var rigth: CollisionShape2D = $StaticBody2D/Rigth
@onready var up: CollisionShape2D = $StaticBody2D/Up
@onready var down: CollisionShape2D = $StaticBody2D/Down

var width: float
var height: float
var border_width: float


## Interpolates height, width and border witdh to the set sizes.
## Also moves and scales border collisions approriately.
func update_size() -> void:
	var tween = get_tree().create_tween().set_parallel()
	tween.tween_property(self.texture, 'height', height, 0.5)
	tween.tween_property(self.texture, 'width', width, 0.5)
	
	tween.tween_property(border.texture, 'width', width + border_width, 0.5)
	tween.tween_property(border.texture, 'height', height + border_width, 0.5)
	
	left.position = Vector2(-width / 2, 0)
	rigth.position = Vector2(width / 2, 0)
	up.position = Vector2(0, -height / 2)
	down.position = Vector2(0, height / 2)
	
	left.shape.size.y = height
	rigth.shape.size.y = height
	up.shape.size.x = width
	down.shape.size.x = width
