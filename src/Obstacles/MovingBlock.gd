extends KinematicBody2D

const FLOOR_NORMAL: = Vector2.UP
const TILE_SIZE = 32

export (String, "UP", "DOWN", "RIGHT", "LEFT") var dir = "UP"

var motion_vector = Vector2()
var moving = false
var speed = 0.1

onready var sprite: Sprite = get_node("Sprite")
	
func _ready():
	if dir == "UP":
		sprite.rotation_degrees = 0
	elif dir == "DOWN":
		sprite.rotation_degrees = 180
	elif dir == "RIGHT":
		sprite.rotation_degrees = 90
	elif dir == "LEFT":
		sprite.rotation_degrees = - 90
				
func _physics_process(_delta):
	if motion_vector != Vector2():
		motion_vector *= TILE_SIZE
		if not test_move(global_transform, motion_vector):
			$Tween.interpolate_property(self, "position", position, position + motion_vector, speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			moving = true
		
	motion_vector = Vector2.ZERO

func _on_Tween_tween_completed(_object, _key):
	moving = false
	
func _on_PlayerDetector_body_entered(_body):
	if moving == false:
		if dir == "UP":
			motion_vector += Vector2(0, - 1)
		elif dir == "DOWN":
			motion_vector += Vector2(0, 1)
		elif dir == "RIGHT":
			motion_vector += Vector2(1, 0)
		elif dir == "LEFT":
			motion_vector += Vector2( - 1, 0)
