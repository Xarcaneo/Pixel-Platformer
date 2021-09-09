extends Actor

onready var animation_player: = $AnimationPlayer

export var can_bounce = true
export var can_move = true
export var speach_bubble : PackedScene
export var bumper_impulse: = 1500

var last_checkpoint: Area2D = null
var teleport_id = 0 
var size

onready var sprite: Sprite = $Sprite
onready var checkpoint_tween: Tween = get_node("CheckPointTween")
	
func _ready():
	var current_skin = GameDataManager.load_player_data()
	sprite.texture = load(GameDataManager.player_skins[current_skin])
	size = sprite.get_texture().get_size() * sprite.get_scale()

func _on_StompDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, bumper_impulse)
	
func _physics_process(delta: float) -> void:
	var direction: = _get_direction()
	check_speach_bubble()
	_velocity = bounce(_velocity, speed)
	_velocity = calculate_move_velocity(_velocity, direction, speed)
	if can_move:
		_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func  _create_speach_bubble(text: String) -> void:
	var new_bubble = speach_bubble.instance()
	new_bubble.bubble_text = text
	new_bubble.global_position = Vector2(sprite.position.x, sprite.position.y - 50)
	add_child(new_bubble)
	Input.action_release("ui_touch")

func check_speach_bubble() -> void:
	if has_node("Speach Bubble"):
		can_move = false
		can_bounce = false
	else:
		if animation_player.current_animation != "die_animation" and animation_player.current_animation != "teleport":
			can_move = true
			can_bounce = true

func _get_direction() -> Vector2:
	return Vector2(
	Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
	1.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2
	) ->Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	return out

func bounce(
		linear_velocity: Vector2,
		speed: Vector2
)  ->Vector2:
	var out = linear_velocity
	if is_on_floor() && can_bounce:
		out.y = speed.y * -1
	return out
	
func teleport():
	animation_player.play("teleport")
	
func use_portal(area):
	for portal in get_tree().get_nodes_in_group("teleport"):
		if(portal != area):
			if(portal.id == area.id):
				if(!portal.lock_portal):
					#area.lock_portal = true
					area.do_lock()
					global_position = portal.global_position
	
func _on_DeadlyDetector_area_entered(area: Area2D) -> void:
	if last_checkpoint != null:
		animation_player.play("die_animation")
		yield(animation_player, "animation_finished")
		get_tree().change_scene_to(GameDataManager.packed_scene)
	else:
		animation_player.play("die_animation")
		yield(animation_player, "animation_finished")
		get_tree().reload_current_scene()

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out


func _on_TeleportDetector_area_entered(area):
	if(!area.lock_portal):
		use_portal(area)
