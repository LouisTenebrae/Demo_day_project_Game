extends CharacterBody2D

class_name Enemy_BigSlime

@export var Health = 10
@export var speed = 80.0
@export var gravitiy = 10
var health_min = 0.0

var player = CharacterBody2D
var player_in_area = false


var slime_chasing: bool
var slime_dead: bool = false
var taking_damage: bool = false
var dealing_damage:bool = false

var dir: Vector2
@export var knockback_force = -20
var is_roaming: bool = true

func _process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravitiy * delta
		velocity.x = 0
		
		
	
	player = Global.playerBody
	

	Global.frogDamageZone = $DmgHitbox
	Global.frogDamageAmount = 10
	
	move(delta)
	move_and_slide()
	
func move(delta):
	if !slime_dead:
		if !slime_chasing:
			velocity += dir * speed * delta
		elif slime_chasing and !taking_damage:
			var dir_to_player = position.direction_to(player.position) * speed
			velocity.x = dir_to_player.x
			dir.x = abs(velocity.x) / velocity.x
		elif taking_damage:
			var knockback_dir = position.direction_to(player.position) * knockback_force
			velocity.x = knockback_dir.x
		is_roaming = true
	elif slime_dead:
		velocity.x = 0
	
func handle_animation():
	var anim_sprite = $AnimationPlayer
	if !slime_dead && !taking_damage && !dealing_damage:
		anim_sprite.play("walk")
		if dir.x == 1:
			anim_sprite.flip_h = true
		elif dir.x == -1:
			anim_sprite.flip_h = false
	elif !slime_dead && taking_damage && !dealing_damage:
		anim_sprite.play("hurt")
		await get_tree().create_timer(0.7).timeout
		taking_damage = false
	elif slime_dead and is_roaming:
		is_roaming = false
		anim_sprite.play("dead")
		await get_tree().create_timer(0.5).timeout
		handle_death()
	elif !slime_dead && dealing_damage:
		anim_sprite.play("attack")
		
func handle_death():
	self.queue_free()
	
func _on_direction_timer_timeout():
	$DirectionTimer.wait_time = choose([1.5, 2.0, 2.5, 3.0])
	if !slime_chasing:
		dir = choose([Vector2.RIGHT,Vector2.LEFT])
		velocity.x = 0
	
func choose(array):
	array.shuffle()
	return array.first
	
func _on_slime_hitbox_area_entered(area: Area2D) -> void:
	var damage = Global.playerDamageAmount
	if area == Global.playerDamageZone:
		take_damage(damage)
		
func take_damage(damage):
	Health -= damage
	taking_damage = true
	if Health <= health_min:
		Health = health_min
		slime_dead = true


func _on_dmg_hitbox_area_entered(area: Area2D) -> void:
	if area == Global.playerHitbox:
		dealing_damage = true
		await get_tree().create_timer(1)
		dealing_damage = false
