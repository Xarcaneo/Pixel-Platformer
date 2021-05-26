tool
extends Button

export(String, FILE) var next_scene_patch: = ""

func _on_button_up():
	get_tree().paused = false
	get_tree().change_scene(next_scene_patch)

func _get_configuration_warning():
	return "next_scene_patch must be set for the button to work" if next_scene_patch == "" else ""
