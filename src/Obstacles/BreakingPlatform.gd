extends Area2D

onready var animationPlayer: AnimationPlayer = $AnimationPlayer

func _on_body_entered(_body):
	animationPlayer.play("Destroy")
	
