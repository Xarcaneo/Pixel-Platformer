extends Node2D

signal coins_updated

var coins: = 0 setget set_coins

func set_coins(value : int) -> void:
	coins = value
	emit_signal("coins_updated") 
