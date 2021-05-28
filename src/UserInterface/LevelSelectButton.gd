tool
extends TextureButton

#Level Stuff
export (int) var level
export(String, FILE) var next_level_patch
export (bool) var enabled
export (bool) var score_goal_met

#Texture Stuff
export (Texture) var blocked_texture
export (Texture) var open_texture
export (Texture) var goal_met
export (Texture) var goal_not_met

onready var level_label = $Label
onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready():
	if GameDataManager.level_info.has(level):
		enabled = GameDataManager.level_info[level]["unlocked"]
		if GameDataManager.level_info[level]["stars_unlocked"] == 1:
			score_goal_met = true
		else:
			score_goal_met = false
	else:
		enabled = false
	setup()

func setup():
	level_label.text = String(level)
	if enabled:
		texture_normal = open_texture
	else:
		texture_normal = blocked_texture


func _pressed() -> void:
	if enabled:
		GameDataManager.current_h_scroll = rect_position.x
		GameDataManager.save_screen_selector_data()
		anim_player.play("fade_in")
		yield(anim_player,"animation_finished")
		get_tree().change_scene(next_level_patch)

func _get_configuration_warning():
	return "next_level_patch must be set for the button to work" if next_level_patch == "" else ""
