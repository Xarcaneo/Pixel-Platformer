extends Area2D

var active: bool = false
 
onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")
export var sound_clip: AudioStream 
export var priority_sound: int

func _on_CheckPoint_player_entered(player):
	if not active:
		if player.last_checkpoint != null:
			player.last_checkpoint.desactivate()
		player.last_checkpoint = self
		AudioManager.play_sfx(sound_clip, priority_sound)
		animated_sprite.play("active")
		active = true

func desactivate() -> void:
	animated_sprite.play("default")
	active = false
