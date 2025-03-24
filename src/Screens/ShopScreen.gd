extends Control

onready var extra: Label = get_node("ExtraPanel/Label")
onready var skin_containers = get_node("SkinContainers")
onready var current_skin_panel_sprite = get_node("CurrentSkinPanel/sprite")
var extra_counter: = 0
	
func _ready():
	for x in GameDataManager.level_info.size() - 1:
		if GameDataManager.level_info[x + 1].has("extra_unlocked"):
			if GameDataManager.level_info[x + 1]["extra_unlocked"] == true:
				extra_counter += 1
	extra.text = "%s" % extra_counter
		
	unlock_skins()
	
func _physics_process(delta):
	current_skin_panel_sprite.texture = load(GameDataManager.player_skins[GameDataManager.current_skin])

func unlock_skins():
	for x in skin_containers.get_child_count():
		skin_containers.get_child(x).unlock(extra_counter)

func _on_ShopScreen_tree_exited():
	pass
