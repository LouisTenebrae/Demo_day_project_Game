extends CharacterBody2D

var input
@export var speed = 100.0
@export var gravity = 10

# Var for jump
var jump_count = 0
@export var max_jump = 2
@export var jump_force = 500


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	movement(delta)

func movement(delta):
	input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if input != 0:
		$AnimSprite.play("run")
		if input > 0:
			$AnimSprite.flip_h = false
			velocity.x += speed * delta
			velocity.x = clamp(speed, 100.0, speed)
			
		if input < 0:
			$AnimSprite.flip_h = true
			velocity.x -= speed * delta
			velocity.x = clamp(-speed, 100.0, -speed)

	if input == 0:
		velocity.x = 0
		$AnimSprite.play("idle")

# Jump Code
	if is_on_floor():
		jump_count = 0
	if !is_on_floor():
		if velocity.y < 0:
			$AnimSprite.play("jump")
			
		if velocity.y > 0:
			$AnimSprite.play("fall")
		
	if Input.is_action_pressed("ui_accept") && is_on_floor() && jump_count < max_jump:
		jump_count += 1
		velocity.y -= jump_force
		velocity.x = input
	if !is_on_floor() && Input.is_action_just_pressed("ui_accept") && jump_count < max_jump:
		jump_count += 1
		velocity.y -= jump_force
		velocity.x = input
	if !is_on_floor() && Input.is_action_just_released("ui_accept") && jump_count < max_jump:
		velocity.y = gravity
		velocity.x = input

	gravity_force()
	move_and_slide()
	
func gravity_force():
	velocity.y += gravity
