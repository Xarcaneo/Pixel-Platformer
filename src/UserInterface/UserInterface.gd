extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("PauseOverlay")
onready var coins: Label = get_node("CoinsPanel/Label")
onready var coins_check_mark: Sprite = get_node("CoinsPanel/CheckMark_Sprite")
onready var extra_check_mark: Sprite = get_node("ExtraPanel/CheckMark_Sprite")
onready var extra_cross_sign: Sprite = get_node("ExtraPanel/CrossSign_Sprite")

var paused: = false setget set_paused

func _ready() -> void :
	PlayerData.connect("coins_updated", self, "update_interface")
	PlayerData.connect("extra_updated", self, "update_interface")
	update_interface()

func _unhandled_input(event: InputEvent) -> void :
	if event.is_action_pressed("pause"):
		self.paused = not paused
		scene_tree.set_input_as_handled()
		
func set_paused(value: bool) -> void :
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value

func update_interface() -> void :
	coins.text = "%s" % PlayerData.coins
	
	if PlayerData.coins == 0:
		coins.visible = false
		coins_check_mark.visible = true
	else:
		coins.visible = true
		coins_check_mark.visible = false
		
	if PlayerData.extra:
		extra_check_mark.visible = true
		extra_cross_sign.visible = false
	else:
		extra_check_mark.visible = false
		extra_cross_sign.visible = true
