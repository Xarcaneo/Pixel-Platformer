extends Node

const SCREEN_WIDTH : int = 1280
const SCREEN_HEIGHT : int = 800

var player_skins = [
	"res://assets/actors/Skin1.png",
	"res://assets/actors/Skin2.png",
	"res://assets/actors/Skin3.png",
	"res://assets/actors/Skin4.png",
	"res://assets/actors/Skin5.png",
	"res://assets/actors/Skin6.png",
	"res://assets/actors/Skin7.png"
]
var current_skin : = 0
var update_camera_position : = false
var current_level  : = 0
var packed_scene = PackedScene.new()
var current_h_scroll: float = 0.0
var level_info = {}
var default_level_info = {
	1:{
		"unlocked": true,
		"extra_unlocked": false
		}
	}
onready var path = "user://save.dat"
onready var path2 = "user://level_selector_save.dat"
onready var path3 = "user://player_data.dat"


func _ready():
	current_skin = load_player_data()
	level_info = load_data()
	current_h_scroll = load_screen_selector_data()
	
func save_data():
	var file = File.new()
	var err = file.open(path, File.WRITE)
	if err != OK:
		print ("something went wrong")
		return
	file.store_var(level_info)
	file.close()

func load_data():
	var file = File.new()
	var err = file.open(path, File.READ)
	if err != OK:
		return default_level_info
	var read = {}
	read = file.get_var()
	return read
	
func save_screen_selector_data():
	var file = File.new()
	var err = file.open(path2, File.WRITE)
	if err != OK:
		return
	file.store_var(current_h_scroll)
	file.close()
	
func load_screen_selector_data():
	var file = File.new()
	var err = file.open(path2, File.READ)
	if err != OK:
		return 0
	var read : float 
	read = file.get_var()
	return read

func save_player_data():
	var file = File.new()
	var err = file.open(path3, File.WRITE)
	if err != OK:
		print ("something went wrong")
		return
	file.store_var(current_skin)
	file.close()
	
func load_player_data():
	var file = File.new()
	var err = file.open(path3, File.READ)
	if err != OK:
		return 0
	var read : float 
	read = file.get_var()
	return read
