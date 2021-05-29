extends Node2D

signal coins_updated
signal extra_updated

var coins: = 0 setget set_coins
var extra: = false setget set_extra

func set_coins(value : int) -> void:
	coins = value
	emit_signal("coins_updated") 

func set_extra(value : bool) -> void:
	extra = value
	emit_signal("extra_updated")
