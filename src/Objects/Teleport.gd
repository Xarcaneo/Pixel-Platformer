extends Area2D

export var sound_clip: AudioStream 
export var priority_sound: int
export(int) var id = 0

var lock_portal = false

func do_lock():
	AudioManager.play_sfx(sound_clip, priority_sound)
	lock_portal = true 
	yield(get_tree().create_timer(0.3),"timeout")
	lock_portal = false
