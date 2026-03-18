extends Area2D

@export var piece_id : int = 0

var time := 0.0
var start_y := 0.0


func _ready():
	start_y = position.y
	body_entered.connect(_on_body_entered)


func _process(delta):
	time += delta
	position.y = start_y + sin(time * 2.0) * 5.0
	rotation += delta * 0.5


func _on_body_entered(body):

	if !body.is_in_group("player"):
		return

	Inventory.add_map_piece(piece_id)

	show_sparkle()

	UIMessage.show_message("Piece collected and added to inventory")

	queue_free()


func show_sparkle():
	var sparkle = preload("res://effects/pickup_sparkle.tscn").instantiate()
	get_tree().current_scene.add_child(sparkle)

	sparkle.global_position = global_position

	var p = sparkle.get_node("CPUParticles2D")
	p.direction = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	p.gravity = Vector2.ZERO
