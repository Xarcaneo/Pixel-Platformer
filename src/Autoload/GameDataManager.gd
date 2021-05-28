extends Node

const SCREEN_WIDTH : int = 1280
const SCREEN_HEIGHT : int = 800

var current_h_scroll: float = 0.0
var level_info = {}
var default_level_info = {
	1:{
		"unlocked": true,
		"high_score": 0,
		"stars_unlocked": 0
		}
	}
onready var path = "user://save.dat"
onready var path2 = "user://level_selector_save.dat"

func _ready():
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
		print("something happened")
	var read = {}
	read = file.get_var()
	return read
	
func save_screen_selector_data():
	var file = File.new()
	var err = file.open(path2, File.WRITE)
	if err != OK:
		print ("something went wrong")
		return
	file.store_var(current_h_scroll)
	file.close()
	
func load_screen_selector_data():
	var file = File.new()
	var err = file.open(path2, File.READ)
	if err != OK:
		return 0
		print("something happened")
	var read : float 
	read = file.get_var()
	return read
