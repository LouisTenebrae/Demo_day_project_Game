class_name Player extends CharacterBody2D

@onready var sfx_jump: AudioStreamPlayer2D = $SFX_jump
@onready var sword_sfx: AudioStreamPlayer2D = $"sword-SFX"

var input
@export var speed = 100.0
@export var gravity = 10

# Var for jump
var jump_count = 0
@export var max_jump = 2
@export var jump_force = 500

# STATE MACHINE
var current_state = player_state.MOVE
enum player_state {MOVE, SWORD, HIT, DEAD}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sword/CollisionSword.disabled = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if player_data.life <= 0:
		current_state = player_state.DEAD
	
	
	match current_state:
		player_state.MOVE:
			movement(delta)
		player_state.SWORD:
			sword(delta)
		player_state.DEAD:
			dead()

func movement(delta):
	input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if input != 0:
		$KnightPlayer.play("run")
		if input > 0:
			$AnimSprite.scale.x = 1
			velocity.x += speed * delta
			velocity.x = clamp(speed, 100.0, speed)
			$Sword/CollisionSword.position.x = 40.75
			
		if input < 0:
			$AnimSprite.scale.x = -1
			velocity.x -= speed * delta
			velocity.x = clamp(-speed, 100.0, -speed)
			$Sword/CollisionSword.position.x = -40.75

	if input == 0:
		velocity.x = 0
		$KnightPlayer.play("idle")

# Jump Code
	if is_on_floor():
		jump_count = 0
	if !is_on_floor():
		if velocity.y < 0:
			$KnightPlayer.play("jump")
			
		if velocity.y > 0:
			$KnightPlayer.play("fall")
		
	if Input.is_action_pressed("ui_accept") && is_on_floor() && jump_count < max_jump:
		sfx_jump.play()
		jump_count += 1
		velocity.y -= jump_force
		velocity.x = input
	if !is_on_floor() && Input.is_action_just_pressed("ui_accept") && jump_count < max_jump:
		sfx_jump.play()
		jump_count += 1
		velocity.y -= jump_force
		velocity.x = input
	if !is_on_floor() && Input.is_action_just_released("ui_accept") && jump_count < max_jump:
		velocity.y = gravity
		velocity.x = input

	if Input.is_action_just_pressed("ui_attack"):
		sword_sfx.play()
		current_state = player_state.SWORD

	gravity_force()
	move_and_slide()
	
func gravity_force():
	velocity.y += gravity

func sword(delta):
	$KnightPlayer.play("attack1")
	input_movement(delta)


func dead():
	$KnightPlayer.play("death")
	velocity.x = 0
	await $KnightPlayer.animation_finished
	player_data.life = 4
	if get_tree():
		get_tree().reload_current_scene()

func input_movement(delta):
	input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if input != 0:
		if input > 0:
			velocity.x += speed * delta
			velocity.x = clamp(speed, 100.0, speed)
			
		if input < 0:
			velocity.x -= speed * delta
			velocity.x = clamp(-speed, 100.0, -speed)
		if input == 0:
			velocity.x = 0

		gravity_force()
		move_and_slide()


func reset_state():
	current_state = player_state.MOVE

func hit():
	current_state = player_state.HIT
	$KnightPlayer.play("hit")


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("attack"):
		player_data.life -= 1
		hit()
		
