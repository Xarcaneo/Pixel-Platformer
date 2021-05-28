extends Control

export var music_clip: AudioStream = load("")

func _ready() -> void:
	AudioManager.play_music(music_clip)
