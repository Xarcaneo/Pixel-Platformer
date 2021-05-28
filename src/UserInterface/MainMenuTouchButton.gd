tool
extends TouchScreenButton

export(String, FILE) var next_scene_patch: = ""

func _get_configuration_warning():
	return "next_scene_patch must be set for the button to work" if next_scene_patch == "" else ""


func _on_MainMenuTouchButton_pressed() -> void:
	pass # Replace with function body.

func _on_pressed() -> void:
	get_tree().change_scene(next_scene_patch)

