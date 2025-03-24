extends Node

onready var path = "user://config.ini"
var music_on = true

func _ready():
	load_config()

func save_config():
	var config = ConfigFile.new()
	config.set_value("audio", "music", music_on)
	
	var err = config.save(path)
	if err != OK:
		print("something went wrong")

func load_config():
	var config = ConfigFile.new()
	var default_options = {
			"sound": true, 
			"music": true
			}
	var err = config.load(path)
	if err != OK:
		return default_options
	var options = {}
	music_on = config.get_value("audio", "music", default_options.music)
	return options
