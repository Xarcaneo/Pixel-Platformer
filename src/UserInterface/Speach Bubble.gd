extends Node2D

var bubble_text = "this is just a test"
var bubble_text_length = 0
var bubble_text_index = 0
var current_text = ""

onready var lbltext = get_node("VBoxContainer/Label")
onready var ninerect = get_node("VBoxContainer/Label/NinePatchRect")

onready var timer = get_node("Timer")

var do_close = false

func _ready():
	bubble_text_length = bubble_text.length()
	timer.start(1)
	pass
	
func _process(delta: float) -> void :
	if Input.is_action_pressed("ui_touch"):
		queue_free()

func _on_Timer_timeout():
	if ( not do_close):
		current_text += bubble_text[bubble_text_index]
		lbltext.text = current_text
		
		if (bubble_text_index < bubble_text_length - 1):
			timer.start(0.04)
			bubble_text_index += 1
		else:
			if ( not do_close):
				do_close = true
				timer.start(1)
