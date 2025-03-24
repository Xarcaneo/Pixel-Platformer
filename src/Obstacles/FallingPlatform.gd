extends KinematicBody2D

const FLOOR_NORMAL: = Vector2.UP

export  var speed: = Vector2(0, 1000.0)
export  var gravity: = 500.0

var _velocity: = Vector2.ZERO
var is_falling: = false

func _physics_process(delta):
	if is_falling:
		_velocity.y = gravity
		_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func _on_Area2D_body_entered(body):
	is_falling = true
