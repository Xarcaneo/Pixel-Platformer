extends Control

export  var price: = 0
export  var skin_index: = 0

onready var label = $Label
onready var button = $Button
onready var skin = $Skin

var pressed: = false

func _ready():
	label.text = str(price)
	
	if GameDataManager.player_skins.size() >= skin_index:
		skin.texture = load(GameDataManager.player_skins[skin_index])
		
func unlock( var extra_counter: int):
	if int(label.text) <= extra_counter:
		button.disabled = false

func _on_Button_pressed():
	GameDataManager.current_skin = skin_index
	GameDataManager.save_player_data()
