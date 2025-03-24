extends StaticBody2D

export (float) var wait_time: = 2.0
export (String, "UP", "DOWN", "RIGHT", "LEFT") var fireball_direction: = "UP"
export  var fireball_speed: = 300

const FIREBALL = preload("res://src/Objects/Fireball.tscn")

onready var sprite: Sprite = $Sprite
onready var position2D: Position2D = $Sprite / Position2D

onready var timer = get_node("Timer")

func _ready():
	set_sprite_rotation()
	timer.set_wait_time(wait_time)
	timer.start()

func _on_Timer_timeout():
	shoot()

func shoot():
	var fireball = FIREBALL.instance()
	get_parent().add_child(fireball)
	fireball.position = position2D.global_position
	fireball.direction = fireball_direction
	fireball.speed = fireball_speed

func set_sprite_rotation():
	if fireball_direction == "UP":
		sprite.rotation_degrees = 0
	elif fireball_direction == "RIGHT":
		sprite.rotation_degrees = 90
	elif fireball_direction == "DOWN":
		sprite.rotation_degrees = 180
	elif fireball_direction == "LEFT":
		sprite.rotation_degrees = - 90
