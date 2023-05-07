extends Node2D


func _ready() -> void:
	set_max_health(get_parent().get_node("Stats").HEALTH)

func set_max_health(val: int):
	$ProgressBar.max_value = val
	$ProgressBar.value = val


func set_current_health(val: int):
	var TW = create_tween()
	TW.tween_property($ProgressBar, "value", val, 0.2)
