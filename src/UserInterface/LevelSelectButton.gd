tool 
extends TextureButton


export (int) var level
export (String, FILE) var next_level_patch
export (bool) var enabled
export (bool) var score_goal_met
export  var index: = 0


export (Texture) var blocked_texture
export (Texture) var open_texture
export (Texture) var goal_met
export (Texture) var goal_not_met

onready var level_label = $Label
onready var anim_player: AnimationPlayer = $AnimationPlayer
onready var extra_sprite: Sprite = $Extra_sprite

func _ready():
	if GameDataManager.level_info.has(level):
		enabled = GameDataManager.level_info[level]["unlocked"]
		score_goal_met = GameDataManager.level_info[level]["extra_unlocked"]
	else:
		enabled = false
	setup()
	
	if GameDataManager.update_camera_position == true:
		if GameDataManager.current_level == level:
			update_camera_position()

func setup():
	level_label.text = String(level)
	if enabled:
		texture_normal = open_texture
	else:
		texture_normal = blocked_texture
		
	if score_goal_met:
		extra_sprite.texture = goal_met
	else:
		extra_sprite.texture = goal_not_met

func _pressed() -> void :
	if enabled:
		update_camera_position()
		anim_player.play("fade_in")
		yield(anim_player, "animation_finished")
		get_tree().change_scene(next_level_patch)

func update_camera_position() -> void :
		GameDataManager.current_h_scroll = rect_position.x + (GameDataManager.SCREEN_WIDTH * index)
		GameDataManager.save_screen_selector_data()

func _get_configuration_warning():
	return "next_level_patch must be set for the button to work" if next_level_patch == "" else ""


