extends Area2D

export  var sound_clip: AudioStream
export  var priority_sound: int

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

func _on_body_entered(_body: Node) -> void :
	picked()

func picked() -> void :
	PlayerData.coins -= 1
	AudioManager.play_sfx(sound_clip, priority_sound)
	anim_player.play("fade_out")
