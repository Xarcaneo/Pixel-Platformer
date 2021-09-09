extends Area2D

export var stomp_impulse: = 1500
export var sound_clip: AudioStream 
export var priority_sound: int

func _on_Bumper_body_entered(body):
	AudioManager.play_sfx(sound_clip, priority_sound)
