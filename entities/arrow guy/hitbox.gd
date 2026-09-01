class_name Projectile extends Grazeable

@export var bullet: Bullet

func get_graze_value() -> float:
	return bullet.get_graze_value()
