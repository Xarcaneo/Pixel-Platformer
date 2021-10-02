extends Node

var play_services

# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.has_singleton("GodotPlayGamesServices"):
		play_services = Engine.get_singleton("GodotPlayGamesServices")

		var show_popups := true
		var request_email := true
		var request_profile := true
		var request_token := ""

		play_services.init(show_popups, request_email, request_profile, request_token)
		play_services.connect("_on_sign_in_success", self, "_on_sign_in_success") # account_id: String
		play_services.connect("_on_sign_in_failed", self, "_on_sign_in_failed") # error_code: int
		
func sign_in():
	if play_services:
		play_services.signIn()
	pass
	
func _on_sign_in_success(userProfile_json: String) -> void:
	var userProfile = parse_json(userProfile_json)

	userProfile["displayName"] # The user's display name
	userProfile["email"] # The user's email
	userProfile["id"] # The user's id
	
func _on_sign_in_failed(error_code: int) -> void:
	print("Error signing in: %s" %error_code)

