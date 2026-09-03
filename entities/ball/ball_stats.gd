class_name BallStats
extends Resource

@export var speed: float
@export var graze: int
@export var graze_mult: float = 1

func get_speed() -> float:
	return self.speed

func get_graze() -> int:
	return self.graze

func get_graze_mult()  -> float:
	return self.graze_mult
