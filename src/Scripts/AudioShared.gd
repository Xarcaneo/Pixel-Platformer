extends Control

export var music_clip: AudioStream 

func _ready() -> void:
	AudioManager.play_music(music_clip)
