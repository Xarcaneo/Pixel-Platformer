extends Area2D

export (int) var link_code: int = 0
export  var sound_clip: AudioStream
export  var priority_sound: int

signal activated()

func _ready():
	if link_code != 0:
		for door in get_tree().get_nodes_in_group("Door"):
			if door.link_code == link_code:
				var __ = connect("activated", door, "_change_state")
				
		for door in get_tree().get_nodes_in_group("Mirror_dispeanser"):
			if door.link_code == link_code:
				var __ = connect("activated", door, "_change_state")

func _on_Button_body_entered(body):
	emit_signal("activated")
	
	if body.name == "Player":
		AudioManager.play_sfx(sound_clip, priority_sound)


func _on_Button_area_entered(_area):
	emit_signal("activated")
