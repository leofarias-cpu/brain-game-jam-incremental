extends Node2D

enum SOUND_EFFECTS {
	GRAZE,
	BALL_BOUNCE,
	MONEY_GO_UP,
	SHOOT,
	HIT_1,
	HIT_2,
	TIMEOUT,
	ROUND_START,
	PURCHASED
}

@export var sound_effects: Dictionary[SOUND_EFFECTS, AudioSettings]

func play_sound(sound: SOUND_EFFECTS) -> void:
	var new_sound = AudioStreamPlayer2D.new()
	var settings = sound_effects[sound]
	
	new_sound.stream = settings.sound
	new_sound.volume_db = settings.volume_db
	new_sound.pitch_scale = settings.pitch_scale
	if settings.pitch_randomnes:
		new_sound.pitch_scale + randf_range(-0.2, 0.2)
	new_sound.finished.connect(new_sound.queue_free)
	
	add_child(new_sound)
	new_sound.play()
