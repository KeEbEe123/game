extends CharacterBody2D

@export var speed := 60
@export var target_offset := 150   # how far from player to stop

@onready var anim = $AnimatedSprite2D

signal reached_target

var walking := false
var target_x := 0.0

func start_walking(start_pos: Vector2):
	global_position = start_pos
	
	# stop some distance to the left of spawn
	target_x = global_position.x - 100
	
	walking = true
	anim.play("walk")
	anim.flip_h = false


func _physics_process(delta):
	if walking:
		velocity.x = -speed

		if global_position.x <= target_x:
			velocity.x = 0
			walking = false
			anim.play("idle")

			reached_target.emit()

		move_and_slide()
