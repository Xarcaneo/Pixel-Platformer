extends Area2D

export (int) var link_code: int = 0
export (String, "UP", "DOWN", "RIGHT", "LEFT") var fireball_direction: = "UP"

var can_shoot: = true

onready var sprite: Sprite = $Sprite
onready var position2D: Position2D = $Sprite / Position2D
onready var timer = get_node("Timer")

const FIREBALL = preload("res://src/Objects/Fireball.tscn")

func _ready():
	set_sprite_rotation()
	timer.set_wait_time(0.1)
	timer.start()
	
func _process(_delta):
	set_sprite_rotation()

func set_sprite_rotation():
	if fireball_direction == "UP":
		sprite.rotation_degrees = 0
	elif fireball_direction == "RIGHT":
		sprite.rotation_degrees = 90
	elif fireball_direction == "DOWN":
		sprite.rotation_degrees = 180
	elif fireball_direction == "LEFT":
		sprite.rotation_degrees = - 90


func _change_state():
	if fireball_direction == "UP":
		fireball_direction = "RIGHT"
	elif fireball_direction == "RIGHT":
		fireball_direction = "DOWN"
	elif fireball_direction == "DOWN":
		fireball_direction = "LEFT"
	elif fireball_direction == "LEFT":
		fireball_direction = "UP"

func _on_Mirror_dispeanser_area_entered(area):
	shoot(area.speed)
	
func shoot( var speed):
	if can_shoot:
		var fireball = FIREBALL.instance()
		get_parent().call_deferred("add_child", fireball)
		fireball.position = position2D.global_position
		fireball.direction = fireball_direction
		fireball.speed = speed
		can_shoot = false


func _on_Timer_timeout():
	can_shoot = true
