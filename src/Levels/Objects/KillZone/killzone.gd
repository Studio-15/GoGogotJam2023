extends Node2D

# When this is added to a level, there needs to be a collision shape called "area"
# and a marker called "marker" added as child to this node.
# This is so that we can shape the collision zone in the level to match the lake/cliff/whatever

enum zone_type {
	cliff,
	lake
}
@export var kill_type: zone_type = zone_type.cliff

func _ready() -> void:
	var killAreaCollision = get_node("area")
	if killAreaCollision:
		killAreaCollision.reparent($KillZoneArea)
	var killMarker = get_node("marker")
	if killMarker:
		$KillMarker.global_position = killMarker.global_position


func _process(delta: float) -> void:
	var a = $KillZoneArea.get_overlapping_bodies()
	if len(a) > 0:
		for i in a:
			print(i.name)


func _on_kill_zone_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		print(body)
		body.pause = true
		if kill_type == zone_type.cliff:
			var TW_scale = create_tween()
			TW_scale.tween_property(body, "scale", Vector2(0.2, 0.2), 3.0)
			var TW_pos = create_tween()
			TW_pos.tween_property(body, "global_position", $KillMarker.global_position, 3.0)
			await TW_pos.finished
			if !is_instance_valid(body):
					return
			body.take_damage(body.get_node("Stats").HEALTH * 4)
		elif kill_type == zone_type.lake:
			var TW_pos = create_tween()
			TW_pos.tween_property(body, "global_position", $KillMarker.global_position, 3.0)
			var TW_modulate = create_tween()
			TW_modulate.tween_property(body.get_node("Sprite2D"), "modulate", Color.BLUE, 2.0)
			await get_tree().create_timer(1.0).timeout
			for i in range(0, body.get_node("Stats").HEALTH):
				if !is_instance_valid(body):
					return
				body.take_damage(2)
				await get_tree().create_timer(0.2).timeout
