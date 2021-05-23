extends Actor

func _physics_process(delta: float) -> void:
	var direction: = _get_direction()
	_velocity = bounce(_velocity, speed)
	_velocity = calculate_move_velocity(_velocity, direction, speed)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

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
	if is_on_floor():
		out.y = speed.y * -1
	return out
