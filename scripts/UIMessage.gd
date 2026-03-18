extends CanvasLayer

@onready var label = $Label


func show_message(text):

	label.text = text
	label.visible = true

	await get_tree().create_timer(2).timeout

	label.visible = false
