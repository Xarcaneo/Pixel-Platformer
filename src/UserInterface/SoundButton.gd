extends TouchScreenButton

#Texture Stuff
export (Texture) var sound_on_texture
export (Texture) var sound_off_texture

func _ready() -> void:
	check_button_status()

func _on_pressed() -> void:
	ConfigManager.music_on = !ConfigManager.music_on
	AudioManager.mute_sounds()
	ConfigManager.save_config()
	check_button_status()

func check_button_status() -> void:
	if ConfigManager.music_on:
		normal = sound_on_texture
	else:
		normal = sound_off_texture
