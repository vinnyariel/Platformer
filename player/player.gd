extends CharacterBody2D

var gravity = 12
var speed = 75
var jump_force = -200
var max_jumps = 2
var current_jumps = max_jumps
var direction: float = 0

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

func _process(_delta):
	# inputs
	direction = Input.get_axis("left", "right")

	# move
	velocity.x = direction * speed

	# gravity
	if not is_on_floor():
		velocity.y += gravity
	else:
		current_jumps = max_jumps
	
	# jump
	if Input.is_action_just_pressed("jump"):
		if current_jumps > 0:
			velocity.y = jump_force
			current_jumps -= 1
	
	# animation
	if direction == 1:
		animation.flip_h = false
		if is_on_floor():
			animation.play("Run")
		else:
			animation.play("Jump")
	elif direction == -1:
		animation.flip_h = true
		if is_on_floor():
			animation.play("Run")
		else:
			animation.play("Jump")
	else:
		if is_on_floor():
			animation.play("Idle")
		else:
			animation.play("Jump")
	
	# collision
	move_and_slide()


