extends Node2D

export var music_clip: AudioStream 
onready var coins: Node2D = get_node("Coins")
onready var extra: Area2D = get_node("Extra")

func _ready() -> void:
	if music_clip != null:
		AudioManager.play_music(music_clip)
	else: 
		AudioManager.music_player.stream = null
	
	restart_data()

func restart_data() -> void:
	if coins:
		PlayerData.coins = coins.get_child_count()	
	if extra == null:
		PlayerData.extra = true
	else:
		PlayerData.extra = false
			
func save_checkpoint() -> void:
	GameDataManager.packed_scene.pack(get_tree().get_current_scene())
