extends Area2D

var speed = 300
var velocity = Vector2()
var direction = "UP"
	
func _physics_process(delta):
	if direction == "RIGHT":
		velocity.x = speed * delta  * 1
	elif direction == "LEFT":
		velocity.x = speed * delta  * -1
	elif direction == "DOWN":
		velocity.y = speed * delta  * 1
	elif direction == "UP":
		velocity.y = speed * delta  * -1
			
	translate(velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Fireball_body_entered(body):
	if body.name == "Player":
		body.kill()
		
	queue_free()
