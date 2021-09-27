extends Area2D

export var sound_clip: AudioStream 
export var priority_sound: int
export var destruction_time: int = 5

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

func _on_Totem_orb_body_entered(body):
	if body.name == "Player" and !body.totem_orb_picked_get():
		body.destruction(destruction_time)
		picked()

func picked() -> void:
	anim_player.play("fade_out")

