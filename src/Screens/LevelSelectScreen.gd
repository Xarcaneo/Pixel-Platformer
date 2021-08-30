extends "res://src/Scripts/AudioShared.gd"

func _ready() -> void:
	yield(get_tree(),"idle_frame")
	$CanvasLayer/ScrollContainer.scroll_horizontal = (GameDataManager.current_h_scroll - GameDataManager.SCREEN_WIDTH / 2)
	
func _physics_process(delta) -> void:
	if 	GameDataManager.update_camera_position == true:
		GameDataManager.update_camera_position = false
		$CanvasLayer/ScrollContainer.scroll_horizontal = (GameDataManager.current_h_scroll - GameDataManager.SCREEN_WIDTH / 2)
	

