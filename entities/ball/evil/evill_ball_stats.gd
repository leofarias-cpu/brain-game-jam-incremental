class_name EvilBallStats extends BallStats

var baseStats: BallStats

func get_speed() -> float:
	return baseStats.speed * 2

func get_graze() -> int:
	return baseStats.graze + 10

func get_graze_mult()  -> float:
	return baseStats.graze_mult + 1
