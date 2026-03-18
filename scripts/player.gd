extends CharacterBody2D

const SPEED = 50.0
const JUMP_VELOCITY = -250.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var spawn_point = $"../SpawnPoint"  # adjust path if needed

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")

	# Flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Animation
	if direction == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("walkForward")

	# Movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func respawn():
	global_position = spawn_point.global_position
	velocity = Vector2.ZERO


func _on_kill_zone_body_entered(body: Node2D) -> void:
	if body == self:
		respawn()
