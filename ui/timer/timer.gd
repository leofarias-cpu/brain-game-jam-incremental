class_name TimerLabel extends RichTextLabel

@export var timer: Timer
var duration: int


func start(time: float):
	self.duration = time
	self.text = str(duration)
	timer.start(1)
	self.modulate = Color.WHITE
	visible = true

func _on_timer_timeout() -> void:
	self.duration -= 1
	self.text = str(duration)
	if duration < 0:
		self.modulate = Color.FIREBRICK
		
func stop():
	timer.stop()
