extends Area2D

var facing_direction: Vector2
@export var velocity: float


func _ready() -> void:
	facing_direction = Vector2.from_angle(deg_to_rad(randf_range(0, 360))).normalized()
	
func _process(delta: float) -> void:
	position += facing_direction * velocity * delta
	
	
	
	
