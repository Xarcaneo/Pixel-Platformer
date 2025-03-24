extends TouchScreenButton

onready var rate: Node2D = get_node("../RateUs")
onready var menu: VBoxContainer = get_node("../Menu")

var show_popup = false
var show_menu = true

func _on_RateButton_pressed():
	show_popup = not show_popup
	rate.visible = show_popup
	
	show_menu = not show_menu
	menu.visible = show_menu
