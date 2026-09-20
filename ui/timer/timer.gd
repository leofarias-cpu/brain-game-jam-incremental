class_name TimerLabel extends RichTextLabel

@export var timer: Timer
var duration: int
@export var progress_bar: TextureProgressBar
@export var effect_label: RichTextLabel


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

func play_timeout_effect(value: int):
	AudioManager.play_sound(AudioManager.SOUND_EFFECTS.TIMEOUT)
	
	effect_label.text = "+ %s!!!!" % value
	effect_label.visible = true
	
	var tween = get_tree().create_tween()
	var facing_direction = Vector2.from_angle(deg_to_rad(randf_range(0, 360))).normalized()
	var position = tween.tween_property(effect_label, "offset_transform_position", Vector2(40, 40) * facing_direction, 1)
	await position.finished
	
	effect_label.visible = false
	effect_label.offset_transform_position = Vector2.ZERO
