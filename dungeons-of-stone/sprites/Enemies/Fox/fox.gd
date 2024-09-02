extends CharacterBody2D


const SPEED = 120.0
var direction = -1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = direction * SPEED

	move_and_slide()
	
	# check if theres a hole ahead, if so turn arund
	if not $GroundDetectorRayCast.is_colliding():
		direction *= -1
	
	# update ground raycast position
	$GroundDetectorRayCast.position.x = 15 * direction
	
	# change sprite direction
	if direction > 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
