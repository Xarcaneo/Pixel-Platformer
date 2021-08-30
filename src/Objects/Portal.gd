tool
extends Area2D

var is_teleporting = false

onready var anim_player: AnimationPlayer = $AnimationPlayer

export var current_level: int
export var next_scene: PackedScene

func _on_body_entered(body: Node) -> void:
	if PlayerData.coins == 0:
		if !is_teleporting:
			body.teleport()
			is_teleporting = true
		teleport()

func _get_configuration_warning() -> String:
	return "The next scene property can't be empty" if not next_scene else ""
	
func teleport() ->void:
	GameDataManager.update_camera_position = true
	GameDataManager.current_level = current_level + 1
	
	anim_player.play("fade_in")
	yield(anim_player,"animation_finished")
	set_level_data()
	get_tree().change_scene_to(next_scene)
	
func set_level_data() -> void:
#Game data save
	if PlayerData.extra:
		GameDataManager.level_info[current_level] = {
		"unlocked": true,
		"extra_unlocked": true
		}
	
	var extra_unlocked = false
	if GameDataManager.level_info.has(current_level + 1):
		if GameDataManager.level_info[current_level + 1].has("extra_unlocked"):
			if GameDataManager.level_info[current_level + 1]["extra_unlocked"]:
				extra_unlocked = true
				
	GameDataManager.level_info[current_level + 1] = {
	"unlocked": true,
	"extra_unlocked": extra_unlocked
	}
	GameDataManager.save_data()
	
