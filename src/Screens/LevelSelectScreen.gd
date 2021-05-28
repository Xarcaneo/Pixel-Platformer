extends "res://src/Scripts/AudioShared.gd"

func _ready() -> void:
	yield(get_tree(),"idle_frame")
	$CanvasLayer/ScrollContainer.set_h_scroll(GameDataManager.current_h_scroll - GameDataManager.SCREEN_WIDTH / 2)
