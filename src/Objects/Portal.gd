tool
extends Area2D

onready var anim_player: AnimationPlayer = $AnimationPlayer

export var current_level: int
export var next_scene: PackedScene

func _on_body_entered(body: Node) -> void:
	body.teleport()
	teleport()

func _get_configuration_warning() -> String:
	return "The next scene property can't be empty" if not next_scene else ""
	
func teleport() ->void:
	anim_player.play("fade_in")
	yield(anim_player,"animation_finished")
	GameDataManager.level_info[current_level + 1] = {
		"unlocked": true,
		"high_score": 0,
		"stars_unlocked": 0
		}
	GameDataManager.save_data()
	get_tree().change_scene_to(next_scene)
