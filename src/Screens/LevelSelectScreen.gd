extends "res://src/Scripts/AudioShared.gd"

signal opened_map

func _ready() -> void :
	connect("opened_map", AchievementsManager, "_map_state")
	yield(get_tree(), "idle_frame")
	$CanvasLayer / ScrollContainer.scroll_horizontal = (GameDataManager.current_h_scroll - GameDataManager.SCREEN_WIDTH / 2)
	emit_signal("opened_map")
	
func _physics_process(delta) -> void :
	if GameDataManager.update_camera_position == true:
		GameDataManager.update_camera_position = false
		$CanvasLayer / ScrollContainer.scroll_horizontal = (GameDataManager.current_h_scroll - GameDataManager.SCREEN_WIDTH / 2)
	

