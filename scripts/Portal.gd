extends Area2D

@export var next_scene : String = "res://scenes/level2.tscn"

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	print("Something entered:", body.name)

	if !body.is_in_group("player"):
		print("Not player")
		return

	print("Player entered portal")

	if Inventory.has_all_pieces():
		print("Teleporting!")
		get_tree().change_scene_to_file(next_scene)
	else:
		print("Missing map pieces")
