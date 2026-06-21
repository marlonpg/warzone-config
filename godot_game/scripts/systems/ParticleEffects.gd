extends Node

class_name ParticleEffects

static func create_damage_popup(position: Vector2, damage: int) -> void:
	var label = Label.new()
	label.text = str(damage)
	label.add_theme_color_override("font_color", Color.RED)
	label.global_position = position
	get_tree().root.add_child(label)

	var tween = create_tween()
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(label, "global_position:y", position.y - 50, 1.0)
	tween.parallel().tween_property(label, "modulate:a", 0.0, 1.0)
	await tween.finished
	label.queue_free()

static func create_death_particles(position: Vector2, color: Color = Color.RED) -> void:
	for i in range(8):
		var particle = Sprite2D.new()
		particle.modulate = color
		particle.scale = Vector2(0.3, 0.3)
		particle.global_position = position
		get_tree().root.add_child(particle)

		var direction = Vector2.from_angle((i / 8.0) * TAU)
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(particle, "global_position", position + direction * 100, 0.8)
		tween.parallel().tween_property(particle, "modulate:a", 0.0, 0.8)
		tween.callback(particle.queue_free)

static func create_hit_particles(position: Vector2) -> void:
	for i in range(4):
		var particle = Sprite2D.new()
		particle.modulate = Color.YELLOW
		particle.scale = Vector2(0.2, 0.2)
		particle.global_position = position
		get_tree().root.add_child(particle)

		var angle = (i / 4.0) * TAU + randf_range(-0.5, 0.5)
		var direction = Vector2.from_angle(angle)
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(particle, "global_position", position + direction * 50, 0.4)
		tween.parallel().tween_property(particle, "modulate:a", 0.0, 0.4)
		tween.callback(particle.queue_free)

static func create_critical_hit(position: Vector2) -> void:
	for i in range(12):
		var particle = Sprite2D.new()
		particle.modulate = Color.GOLD
		particle.scale = Vector2(0.5, 0.5)
		particle.global_position = position
		get_tree().root.add_child(particle)

		var angle = (i / 12.0) * TAU
		var direction = Vector2.from_angle(angle)
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_QUAD)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(particle, "global_position", position + direction * 80, 0.6)
		tween.parallel().tween_property(particle, "modulate:a", 0.0, 0.6)
		tween.callback(particle.queue_free)

static func create_tween() -> Tween:
	return get_tree().create_tween()
