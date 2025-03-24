extends Area2D

const DISPEANSER_BLOCK = preload("res://src/Objects/Dispeanser_block.tscn")

export (int) var link_code: int = 0
export (String, "UP", "DOWN", "RIGHT", "LEFT") var block_direction: = "UP"

var can_shoot: = true

onready var sprite: Sprite = $Sprite
onready var position2D: Position2D = $Sprite / Position2D
onready var timer = get_node("Timer")

func _ready():
	set_sprite_rotation()
	timer.set_wait_time(0.1)
	timer.start()
	
func _process(_delta):
	set_sprite_rotation()

func set_sprite_rotation():
	if block_direction == "UP":
		sprite.rotation_degrees = 0
	elif block_direction == "RIGHT":
		sprite.rotation_degrees = 90
	elif block_direction == "DOWN":
		sprite.rotation_degrees = 180
	elif block_direction == "LEFT":
		sprite.rotation_degrees = - 90


func _change_state():
	if block_direction == "UP":
		block_direction = "RIGHT"
	elif block_direction == "RIGHT":
		block_direction = "DOWN"
	elif block_direction == "DOWN":
		block_direction = "LEFT"
	elif block_direction == "LEFT":
		block_direction = "UP"

func _on_Timer_timeout():
	can_shoot = true

func _on_Block_dispeanser_area_entered(area):
	if not area.get("speed") == null:
		shoot(area.speed)
	
func shoot( var speed):
	if can_shoot:
		var dispeanser_block = DISPEANSER_BLOCK.instance()
		get_parent().call_deferred("add_child", dispeanser_block)
		dispeanser_block.position = position2D.global_position
		dispeanser_block.direction = block_direction
		dispeanser_block.speed = speed
		can_shoot = false
