extends Actor

signal died

onready var animation_player: = $AnimationPlayer

export  var bumper_impulse: = 1500
export  var sound_clip: AudioStream
export  var priority_sound: int

var can_move = true
var last_checkpoint: Area2D = null
var teleport_id = 0
var size
var totem_orb_picked: = false setget , totem_orb_picked_get

onready var sprite: Sprite = $Sprite
onready var checkpoint_tween: Tween = get_node("CheckPointTween")
onready var destruction_timer: Timer = $Destruction_timer
onready var label: Label = $Label

func _ready():
	var current_skin = GameDataManager.load_player_data()
	sprite.texture = load(GameDataManager.player_skins[current_skin])
	size = sprite.get_texture().get_size() * sprite.get_scale()
	
func _on_StompDetector_area_entered(_area: Area2D) -> void :
	_velocity = calculate_stomp_velocity(_velocity, bumper_impulse)
	AudioManager.play_sfx(sound_clip, priority_sound)
	
func _physics_process(_delta: float) -> void :
	var direction: = _get_direction()
	_velocity = bounce(_velocity, speed)
	_velocity = calculate_move_velocity(_velocity, direction, speed)

	if can_move:
		_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
		
	
	if totem_orb_picked:
		var time_left = destruction_timer.time_left
		time_left = floor(time_left)
		label.text = String(time_left)

func _get_direction() -> Vector2:
	return Vector2(
	Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), 
	1.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2, 
		direction: Vector2, 
		speed: Vector2
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	return out

func bounce(
		linear_velocity: Vector2, 
		speed: Vector2
) -> Vector2:
	var out = linear_velocity
	if is_on_floor():
		out.y = speed.y * - 1
	return out
	
func teleport():
	animation_player.play("teleport")
	
func use_portal(area):
	for portal in get_tree().get_nodes_in_group("teleport"):
		if (portal != area):
			if (portal.id == area.id):
				if ( not portal.lock_portal):
					
					area.do_lock()
					global_position = portal.global_position
	
func _on_DeadlyDetector_area_entered(_area: Area2D) -> void :
	if not animation_player.current_animation == "die_animation":
		kill()

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = - impulse
	return out


func _on_TeleportDetector_area_entered(area):
	if ( not area.lock_portal):
		use_portal(area)

func kill():
	emit_signal("died")
	label.visible = false
	if last_checkpoint != null:
		animation_player.play("die_animation")
		yield(animation_player, "animation_finished")
		get_tree().change_scene_to(GameDataManager.packed_scene)
	else:
		animation_player.play("die_animation")
		yield(animation_player, "animation_finished")
		get_tree().reload_current_scene()

func destruction( var destruction_time: int):
	totem_orb_picked = true
	label.visible = true
	destruction_timer.set_wait_time(destruction_time)
	destruction_timer.start()
	
func deactivate():
	totem_orb_picked = false
	label.visible = false
	destruction_timer.stop()
	
func totem_orb_picked_get():
	return totem_orb_picked

func _on_Destruction_timer_timeout():
	kill()
