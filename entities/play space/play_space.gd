@tool
class_name PlaySpace
extends Sprite2D

@export var border: Sprite2D
@onready var left: CollisionShape2D = $StaticBody2D/Left
@onready var rigth: CollisionShape2D = $StaticBody2D/Rigth
@onready var up: CollisionShape2D = $StaticBody2D/Up
@onready var down: CollisionShape2D = $StaticBody2D/Down

var width: float = 50
var height: float = 50
var border_width: float = 4

func _ready() -> void:
	if Engine.is_editor_hint():
		update_size()

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

## Gets a point inside the play area.
func get_point() -> Vector2:
	return Vector2(randf_range(-width, width), randf_range(-height, height))

## Gets a point relative to a side of the space,
## that is at between min_distance and max_distance from the border.
## [br]
## max_distance is a percentage [0-1] of the side and min_distance is pixels fuck you.
func get_point_from_side(side: Vector2, max_distance: float, min_distance: float = 10) -> Vector2:
	match side:
		Vector2.UP: 
			var distance = randf_range(min_distance, height / 2 * max_distance)
			var x_axis = randf_range(-width / 2 + min_distance, width / 2 - min_distance)
			return Vector2(x_axis, -height / 2 + distance)
		Vector2.RIGHT: 
			var distance = randf_range(min_distance, width / 2 * max_distance)
			var y_axis = randf_range(-height / 2 + min_distance, width / 2 - min_distance)
			return Vector2(width / 2 - distance, y_axis)
		Vector2.DOWN:
			var distance = randf_range(min_distance, height / 2 * max_distance)
			var x_axis = randf_range(-width / 2 + min_distance, width / 2 - min_distance)
			return Vector2(x_axis, height / 2 - distance)
		Vector2.LEFT:
			var distance = randf_range(min_distance, width / 2 * max_distance)
			var y_axis = randf_range(-height / 2 + min_distance, width / 2 - min_distance)
			return Vector2(-width / 2 + distance, y_axis)
		var err:
			push_error("Mano tu tá louco KRL eu falei que tinha que ser um dos vetores e tu me passa uma merda dessa: %s" % err)
			return Vector2.ZERO
