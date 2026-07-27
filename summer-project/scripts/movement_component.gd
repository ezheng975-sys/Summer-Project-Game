extends Node
class_name MovementComponent

# variables and constants
@export var parent: CharacterBody2D
@export var speed: float = 180.0
@export var jump_velocity: float = -310.0
@export var falling_gravity_multiplier: float = 1.5
@export var coyote_duration: float = 0.1
@export var jump_buffer: float = 0.12
@export var friction: float = 1600.0
@export var acceleration: float = 1100.0
@export var air_control_loss: float = 1.3
var bullet_scene = preload("res://scenes/bullet.tscn")
var jumping: bool = false
var can_jump: bool = false
var coyote_timer: float = 0
var jump_buffer_timer: float = 0


# default 60 times per second 
func _physics_process(delta: float) -> void:
	
	# movement stuff (coyote, buffer and inputs)
	if not parent:
		parent = get_parent()
		
	if not parent.is_on_floor():
		coyote_timer -= delta
		can_jump = false
		if parent.velocity.y > 0:
			parent.velocity += parent.get_gravity() * delta * falling_gravity_multiplier
		else:
			parent.velocity += parent.get_gravity() * delta
	elif parent.is_on_floor():
		jumping = false
		coyote_timer = coyote_duration
		can_jump = true
		
	if Input.is_action_just_pressed("p" + str(parent.player_id) + "_up"):
		jump_buffer_timer = jump_buffer
		if can_jump == true:
			parent.velocity.y = jump_velocity
			jumping = true
			jump_buffer_timer = 0
			coyote_timer = 0
	jump_buffer_timer -= delta
	
	if Input.is_action_just_released("p" + str(parent.player_id) + "_up") and parent.velocity.y < 0:
		parent.velocity.y = 0
	
	if jump_buffer_timer > 0.0 and coyote_timer > 0.0:
		parent.velocity.y = jump_velocity
		jump_buffer_timer = 0.0
		coyote_timer = 0.0

	# direction and inputs
	var direction := Input.get_axis("p" + str(parent.player_id) + "_left", "p" + str(parent.player_id) + "_right")
	if parent.is_on_floor():
		if direction:
			parent.velocity.x = move_toward(parent.velocity.x, direction * speed, acceleration * delta)
		else:
			parent.velocity.x = move_toward(parent.velocity.x, 0, friction * delta)
	elif not parent.is_on_floor():
		if direction:
			parent.velocity.x = move_toward(parent.velocity.x, direction * speed, acceleration / air_control_loss * delta)
		else:
			parent.velocity.x = move_toward(parent.velocity.x, 0, friction / air_control_loss * delta)
	
	parent.move_and_slide()
	
	
	
	
		
	# sprite flipping
	if direction != 0:
		$"../AnimatedSprite2D".flip_h = (direction < 0)
