extends CharacterBody2D

@export var speed = 40
@export var gravity = 10
@export var health = 10
var dir

var current_state
enum slime_states {IDLE, RIGHT,LEFT, CHASE, ATTACK, DEAD}

func _ready() -> void:
	$DmgHitbox/CollisionShape2D.disabled = true
	_on_timer_timeout()
	
	
func _physics_process(_delta: float) -> void:
	if !is_on_floor():
		velocity.y = gravity * speed
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
		slime_states.ATTACK:
			attack()
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
		$DmgHitbox/CollisionShape2D.position.x = 12.2
		$aim/aim.position.x = 11

func move_left():
	if is_on_floor():
		velocity = Vector2.LEFT * speed
		$AnimationPlayer.play("walk")
		$Sprite2D.flip_h = false
		$DmgHitbox/CollisionShape2D.position.x = -12.2
		$aim/aim.position.x = -11

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


func _on_timer_timeout() -> void:
	if  $LeftRayCast2D.is_colliding():
		chase_left()
	elif $RigthRayCast2D.is_colliding():
		chase_right()
	elif random_generator():
		$Timer.start
	
	

func chase_left():
	if $LeftRayCast2D.is_colliding():
		current_state = slime_states.LEFT

func chase_right():
	if $RigthRayCast2D.is_colliding():
		current_state = slime_states.RIGHT



func attack():
	velocity.x = 0
	$AnimationPlayer.play("attack")
	await $AnimationPlayer.animation_finished
	_on_timer_timeout()


func _on_aim_body_entered(body: Node2D) -> void:
	if body is Player:
		current_state = slime_states.ATTACK


func _on_slime_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("sword"):
		health -= 1
