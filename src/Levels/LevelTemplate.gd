extends Node2D

export var music_clip: AudioStream = load("")

onready var coins: Node2D = $Coins

func _ready() -> void:
	AudioManager.play_music(music_clip)
	
	if coins:
		PlayerData.coins = coins.get_child_count()
