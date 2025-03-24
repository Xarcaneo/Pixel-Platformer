extends StaticBody2D

signal activated()

export  var sound_clip: AudioStream
export  var priority_sound: int
export (int) var link_code: int = 0

var activated: = false

onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	if link_code != 0:
		for door in get_tree().get_nodes_in_group("Door"):
			if door.link_code == link_code:
				var __ = connect("activated", door, "_change_state")

func _on_Area2D_body_entered(body):
	if body.name == "Player" and not activated and body.totem_orb_picked_get():
		AudioManager.play_sfx(sound_clip, priority_sound)
		emit_signal("activated")
		activated = true
		animation_player.play("activated")
		body.deactivate()
