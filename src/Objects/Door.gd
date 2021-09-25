extends StaticBody2D

export(int) var link_code: int = 0 
export(String, "OPEN", "CLOSED") var is_open = "CLOSED"

onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

func _ready():
	if is_open == "OPEN":
		modulate.a = 0
		animation_player.play("open")
	else:
		modulate.a = 255
		animation_player.play("closed")

func _change_state() -> void:
	if !animation_player.is_playing():
		if is_open == "OPEN":
			animation_player.play("fade_in")
			is_open = "CLOSED"
		elif is_open == "CLOSED":
			animation_player.play("fade_out")
			is_open = "OPEN"
		
