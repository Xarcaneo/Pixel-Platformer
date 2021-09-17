extends Node

var _play_services = null

func _ready():
	_init()
	_connect_signals()
	sign_in()
	
func _init() -> void:
	if Engine.has_singleton("GodotPlayGamesServices"):
		_play_services = Engine.get_singleton("GodotPlayGamesServices")
		
		_play_services.init(true)
	
func sign_in() -> void:
	if _play_services:
		_play_services.signIn()

func _connect_signals() -> void:
	if _play_services:
		_play_services.connect("_on_sign_in_succes", self, "_on_sign_in_succes")
		_play_services.connect("_on_sign_in_fail", self, "_on_sign_in_fail")
		
func _on_sign_in_succes(account_id : String ):
	print("Succesful sign in")
	pass
	
func _on_sign_in_fail(error_code : String ):
	print("Failed to sign in ith error code %s" % error_code)
	pass
