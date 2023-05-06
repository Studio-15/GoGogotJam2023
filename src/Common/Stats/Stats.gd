extends Node

class_name entity_stats

@export var HEALTH: int = 10:
	set(val):
		HEALTH = val
		if HEALTH < 1:
			get_parent().on_death()
@export var MOVE_SPEED: int = 10
@export var ATTACK: int = 10
@export var ATTACK_SPEED: int = 10


func take_damage(val: int):
	HEALTH -= val
