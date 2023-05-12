extends Node2D


var enemies_alive: int = 0:
	set(val):
		enemies_alive = val
		if val == 0:
			EventBus.level_complete()


func _ready() -> void:
	enemies_alive = len(get_tree().get_nodes_in_group("Enemy"))
	EventBus.enemy_death_signal.connect(on_enemy_death)


func on_enemy_death(type: Enums.ENEMY_TYPE):
	enemies_alive -= 1
