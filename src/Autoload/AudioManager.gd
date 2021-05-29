extends Node

var dic : Dictionary = {}
var master_sound = AudioServer.get_bus_index("Master")

onready var music_player: AudioStreamPlayer = $Music/Music_player
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var sfx: Node = $Sfx

func mute_sounds() -> void:
	if ConfigManager.music_on:
		AudioServer.set_bus_mute(master_sound, false)
	else:
		AudioServer.set_bus_mute(master_sound, true)
		
func play_sfx(audio_clip : AudioStream, priority : int = 0):
	for child in sfx.get_children():
		if child.playing == false:
			child.stream = audio_clip
			child.play()
			dic[child.name] = priority
			break
			
		if child.get_index() == sfx.get_child_count() -1:
			var priority_player= find_oldest_player()
			if priority_player != null:
				priority_player.stream = audio_clip
				priority_player.play()
	pass
	
func check_priority(_dic : Dictionary, _priority):
	var prio_list : Array = []
	
	for key in _dic:
		if _priority > dic[key]:
			prio_list.append(key)
			
	var last_prio = null
	for key in prio_list:
		if last_prio == null:
			last_prio = key
			continue
		if _dic[key] < _dic[last_prio]:
			last_prio = key
	return last_prio
	pass
	
func find_oldest_player():
	var last_child = null
	
	for child in sfx.get_children():
		if last_child == null:
			last_child = child
			continue
		
		if child.get_playback_position() > last_child.get_playback_position():
			last_child = child
			
		return last_child
		pass

func play_music(music_clip : AudioStream):
	if music_player.stream == music_clip:
		pass
	else:
		if music_player.stream != null:
			animation_player.play("fade_out")
			yield(animation_player,"animation_finished")
			music_player.stream = music_clip
			music_player.play()
			animation_player.play("fade_in")
		else:
			music_player.stream = music_clip
			music_player.play()
	
