class_name AudioSettings extends Resource

@export var sound: AudioStream
@export_range(-40, 20) var volume_db := 0
@export_range(0.0, 4.0, 0.1) var pitch_scale := 1.0
@export var pitch_randomnes := false
