extends Area2D

export  var speed = 300
export (String, "UP", "DOWN", "RIGHT", "LEFT") var direction: = "UP"
	
var velocity = Vector2()

onready var animation_player: AnimationPlayer = $AnimationPlayer

func _physics_process(delta):
	if direction == "RIGHT":
		velocity.x = speed * delta * 1
	elif direction == "LEFT":
		velocity.x = speed * delta * - 1
	elif direction == "DOWN":
		velocity.y = speed * delta * 1
	elif direction == "UP":
		velocity.y = speed * delta * - 1
			
	translate(velocity)

func _on_Dispeanser_block_body_entered(body):
	animation_player.play("fade_out")

func _on_Dispeanser_block_area_entered(area):
	animation_player.play("fade_out")
