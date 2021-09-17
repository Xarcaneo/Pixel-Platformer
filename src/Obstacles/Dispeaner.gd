extends StaticBody2D

export(float) var wait_time: = 2.0
export(String, "UP", "DOWN", "RIGHT", "LEFT") var fireball_direction: = "UP"
export var fireball_speed: = 300

const FIREBALL =  preload("res://src/Objects/Fireball.tscn")

onready var timer = get_node("Timer")

func _ready():
	timer.set_wait_time(wait_time)
	timer.start()

func _on_Timer_timeout():
	shoot()

func shoot():
	var fireball = FIREBALL.instance()
	get_parent().add_child(fireball)
	fireball.position = $Position2D.global_position
	fireball.direction = fireball_direction
	fireball.speed = fireball_speed
