extends CanvasLayer

@onready var container = $Panel/MapContainer

func _ready():
	Inventory.map_piece_added.connect(add_piece)

func _process(delta):
	if Input.is_action_pressed("inventory"):
		visible = true
	else:
		visible = false


func add_piece(id):
	var texture_rect = TextureRect.new()
	texture_rect.texture = load("res://assets/mapPieces/piece_" + str(id) + ".png")
	texture_rect.custom_minimum_size = Vector2(64,64)

	container.add_child(texture_rect)
