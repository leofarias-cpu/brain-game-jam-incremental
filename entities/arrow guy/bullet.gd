class_name Bullet extends CharacterBody2D

@export var stats: BulletStats
var direction: int = 1

signal hit(bullet: Bullet)

var disabled := true

func _physics_process(delta: float) -> void:
	if disabled: return
	
	var collision := move_and_collide(Vector2(stats.speed, 0) * direction *delta)
	if collision:
		hit.emit(self)

func get_graze_value() -> int:
	return stats.graze * stats.graze_mult
