extends CharacterBody2D

@export var speed = 50
@export var gravity = 10
@export var health = 5
var dir

var current_state
enum slime_states {IDLE, RIGHT, LEFT, DEAD}

func _ready() -> void:
	random_generator()
	
	
func _physics_process(_delta: float) -> void:
	if !is_on_floor():
		velocity.y = gravity
		velocity.x = 0

	if health <= 0:
		current_state = slime_states.DEAD

	match current_state:
		slime_states.IDLE:
			idle()
		slime_states.RIGHT:
			move_right()
		slime_states.LEFT:
			move_left()
		slime_states.DEAD:
			dead()
					
	move_and_slide()
	
func idle():
	if is_on_floor():
		velocity.x = 0
		$AnimationPlayer.play("idle")

func move_right():
	if is_on_floor():
		velocity = Vector2.RIGHT * speed
		$AnimationPlayer.play("walk")
		$Sprite2D.flip_h = true

func move_left():
	if is_on_floor():
		velocity = Vector2.LEFT * speed
		$AnimationPlayer.play("walk")
		$Sprite2D.flip_h = false
		
func dead():
	$AnimationPlayer.play("dead")
	await $AnimationPlayer.animation_finished
	

func random_generator():
	dir = randi() % 3
	random_dir()
	print(dir)
	
func random_dir():
	match dir:
		0:
			current_state = slime_states.IDLE
		1:
			current_state = slime_states.RIGHT
		2:
			current_state = slime_states.LEFT


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("sword"):
		health -= 1


func _on_timer_timeout() -> void:
	random_generator()
	$Timer.start
