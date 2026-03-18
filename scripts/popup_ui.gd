extends CanvasLayer

@onready var panel = $Panel
@onready var label = $Panel/Label
@onready var hint = $HintLabel

func _ready():
	panel.visible = false
	hint.visible = false
	hint.text = ""

func show_popup(text):
	label.text = text
	panel.visible = true

func hide_popup():
	panel.visible = false

func show_hint(text):
	hint.text = text
	hint.visible = true

func hide_hint():
	hint.visible = false
