extends Area2D

signal extra_picked

export  var sound_clip: AudioStream
export  var priority_sound: int

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

func _ready():
	connect("extra_picked", AchievementsManager, "_extra_picked_state")


func _on_body_entered(body: Node) -> void :
	picked()

func picked() -> void :
	emit_signal("extra_picked")
	PlayerData.extra = true
	AudioManager.play_sfx(sound_clip, priority_sound)
	anim_player.play("fade_out")

