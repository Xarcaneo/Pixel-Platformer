extends Camera2D

var screen_viewport_width = ProjectSettings.get_setting("display/window/size/width")
var screen_viewport_height = ProjectSettings.get_setting("display/window/size/height")
onready var player = get_node("../Player")

func _process(_delta):
	var coords = get_player_coords()
	
	if coords[0] == 0:
		position.x = screen_viewport_width / 2
	else:
		position.x = screen_viewport_width / 2
		for _x in range(coords[0]):
			position.x += screen_viewport_width
		
	if coords[1] == 0:
		position.y = screen_viewport_height / 2
	else:
		position.y = screen_viewport_height / 2
		for _x in range(coords[1]):
			position.y += screen_viewport_height
			
func get_player_coords():
	var coords = [int(player.position.x / screen_viewport_width), int(player.position.y / screen_viewport_height)]
	return coords
