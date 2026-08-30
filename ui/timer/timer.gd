class_name TimerLabel extends RichTextLabel

@export var timer: Timer
var duration: int
@export var progress_bar: TextureProgressBar


func start(time: float):
	self.duration = time
	self.text = str(duration)
	timer.start(1)
	self.modulate = Color.WHITE
	
	progress_bar.max_value = duration

func _on_timer_timeout() -> void:
	progress_bar.value += 1
	
	self.duration -= 1
	self.text = str(duration)
	
	if duration < 0:
		self.modulate = Color.FIREBRICK
		
	
func stop():
	timer.stop()
