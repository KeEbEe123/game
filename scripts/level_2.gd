extends Node2D

@onready var player = $Player
@onready var npc = $me
@onready var interaction = $InteractionObject
@onready var dialogue_label = $CanvasLayer/Label

var event_started = false
var dialogue_active = false

var dialogue_lines = [
	"YOU MADE IT",
	"I missed you so much",
	"I love youuuu anushka <3",
	"Happy anniversary <3",
	"we kiss"
]

var dialogue_index = 0

func _ready():
	dialogue_label.visible = false
	npc.visible = false

	interaction.interacted.connect(_on_interacted)
	npc.reached_target.connect(_on_npc_reached)


func _on_interacted():
	if event_started:
		return

	event_started = true

	npc.visible = true
	var spawn_pos = player.global_position + Vector2(120, 0)
	npc.start_walking(spawn_pos)


func _on_npc_reached():
	start_dialogue()


# 💬 START DIALOGUE
func start_dialogue():
	dialogue_active = true
	dialogue_index = 0
	dialogue_label.visible = true
	dialogue_label.text = dialogue_lines[dialogue_index]


# 🎮 HANDLE INPUT FOR NEXT LINE
func _process(delta):
	if dialogue_active and Input.is_action_just_pressed("interact"):
		dialogue_index += 1

		if dialogue_index < dialogue_lines.size():
			dialogue_label.text = dialogue_lines[dialogue_index]
		else:
			end_dialogue()


func end_dialogue():
	dialogue_active = false
	dialogue_label.visible = false
	
	get_tree().quit()
