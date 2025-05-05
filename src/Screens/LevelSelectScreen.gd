extends "res://src/Scripts/AudioShared.gd"

var dragging = false
var drag_start_pos = Vector2()
var initial_scroll_pos = 0

func _ready() -> void:
	yield(get_tree(), "idle_frame")
	$CanvasLayer/ScrollContainer.scroll_horizontal = int(GameDataManager.current_h_scroll - GameDataManager.SCREEN_WIDTH / 2.0)
	
func _physics_process(_delta) -> void:
	if GameDataManager.update_camera_position == true:
		GameDataManager.update_camera_position = false
		$CanvasLayer/ScrollContainer.scroll_horizontal = int(GameDataManager.current_h_scroll - GameDataManager.SCREEN_WIDTH / 2.0)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				dragging = true
				drag_start_pos = event.position
				initial_scroll_pos = $CanvasLayer/ScrollContainer.scroll_horizontal
			else:
				dragging = false
	
	elif event is InputEventMouseMotion and dragging:
		var drag_distance = event.position.x - drag_start_pos.x
		$CanvasLayer/ScrollContainer.scroll_horizontal = initial_scroll_pos - drag_distance
		GameDataManager.current_h_scroll = $CanvasLayer/ScrollContainer.scroll_horizontal + GameDataManager.SCREEN_WIDTH / 2.0
