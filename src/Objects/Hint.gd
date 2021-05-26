tool
extends Area2D

export var text: String

func _on_body_entered(body: Node) -> void:
	body._create_speach_bubble(text)
	queue_free()

func _get_configuration_warning() -> String:
	return "The text property can't be empty" if not text else ""
	
