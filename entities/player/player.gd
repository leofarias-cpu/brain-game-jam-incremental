extends CharacterBody2D

@export var SPEED = 30.0
@export var grazing_area: Area2D
@export var grazing_collision_shape: CollisionShape2D
@export var hitbox: Area2D
@export var sprite: Sprite2D

signal graze
signal hit


func _ready() -> void:
	grazing_area.area_entered.connect(_on_graze_area_area_entered)
	hitbox.area_entered.connect(_on_hitbox_area_entered)

func _physics_process(_delta: float) -> void:

	var direction_x := Input.get_axis("left", "right")
	var direction_y := Input.get_axis("up", "down")
	
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = 0
		
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = 0
	move_and_slide()


func _on_graze_area_area_entered(_area: Area2D) -> void:
	graze.emit()
	var tween = get_tree().create_tween()
	tween.tween_property(sprite, 'modulate', Color(0.431, 0.865, 0.51, 1.0), 0.2)
	tween.tween_property(sprite, 'modulate', Color(1.0, 1.0, 1.0, 1.0), 0.1)

func _on_hitbox_area_entered(_area: Area2D) -> void:
	hit.emit()
	var tween = get_tree().create_tween()
	tween.tween_property(sprite, 'modulate', Color(0.99, 0.33, 0.198, 1.0), 0.3)
	tween.tween_property(sprite, 'modulate', Color(1.0, 1.0, 1.0, 1.0), 0.2)
