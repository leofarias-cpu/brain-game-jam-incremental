class_name EvilBall extends Ball

func set_stats(stats: BallStats):
	var evil_stats = EvilBallStats.new()
	evil_stats.baseStats = stats
	self.stats = evil_stats
