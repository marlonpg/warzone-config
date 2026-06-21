extends Node2D

class_name DroppedGold

var amount: int = 0

func _ready() -> void:
	var sprite = Sprite2D.new()
	sprite.modulate = Color.YELLOW
	sprite.scale = Vector2(0.5, 0.5)
	add_child(sprite)

	var area = Area2D.new()
	var shape = CircleShape2D.new()
	shape.radius = 15
	var collision = CollisionShape2D.new()
	collision.shape = shape
	area.add_child(collision)
	add_child(area)

	area.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var game_manager = get_tree().get_first_node_in_group("game_manager")
		if game_manager:
			game_manager.add_gold(amount)
		queue_free()
