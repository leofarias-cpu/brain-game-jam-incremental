class_name EvilBall extends Ball

@export var graze_area: Area2D
var grazing_enabled := false
signal graze(value: int)

func set_stats(new_stats: BallStats):
	var evil_stats = EvilBallStats.new()
	evil_stats.baseStats = new_stats
	self.stats = evil_stats
	

func reset():
	super.reset()
	graze_area.monitoring = grazing_enabled and true


func _on_graze_area_area_entered(area: Area2D) -> void:
	if grazing_enabled and area is Grazeable:
		graze.emit(area.get_graze_value())
