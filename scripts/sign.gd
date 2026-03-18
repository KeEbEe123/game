extends Node2D
@export var popup : CanvasLayer

var player_in_range = false
var popup_open = false
var message_index = 0

var message_parts = [
	"I gave you a summoning spell for our anniversary...",
	"But an evil sorceress M",
	"magically ripped it into 4 pieces",
	"and scattered them across the world.",
	"Your mission is to find all 4 of them",
	"and piece them together.",
	"Only then can you perform the spell",
	"and summon me back into the world."
]


func _ready():
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)


func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		
		if !popup_open:
			message_index = 0
			popup.show_popup(message_parts[message_index])
			popup_open = true
			return
		
		# Go to next message part
		message_index += 1
		
		if message_index < message_parts.size():
			popup.show_popup(message_parts[message_index])
		else:
			# End of message
			popup.hide_popup()
			popup_open = false
			message_index = 0


func _on_body_entered(body):
	if body.name == "Player":
		player_in_range = true
		popup.show_hint("Press E to read")


func _on_body_exited(body):
	if body.name == "Player":
		player_in_range = false
		popup.hide_popup()
		popup.hide_hint()
		popup_open = false
		message_index = 0
