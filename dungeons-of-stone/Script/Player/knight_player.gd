extends CharacterBody2D

var input
@export var speed = 100.0
@export var gravity = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	movement(delta)

func movement(delta):
	input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if input != 0:
		$Spriteidle.hide()
		$SpriteRun.show()
		if input > 0:
			$SpriteRun.flip_h = false
			$AnimationPlayer.play("run")
			velocity.x += speed * delta
			velocity.x = clamp(speed, 100.0, speed)
		
			
		if input < 0:
			$AnimationPlayer.play("run")
			$SpriteRun.flip_h = true
			velocity.x -= speed * delta
			velocity.x = clamp(-speed, 100.0, -speed)

	if input == 0:
		$SpriteRun.hide()
		$Spriteidle.show()
		velocity.x = 0
		$AnimationPlayer.play("idle")
	
	gravity_force()
	move_and_slide()
	
func gravity_force():
	velocity.y += gravity
