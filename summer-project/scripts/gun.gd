extends Node2D
class_name Gun

var bullet_scene = preload("res://scenes/bullet.tscn")
@onready var muzzle: Marker2D = $MuzzlePoint
@onready var parent: CharacterBody2D = get_parent()
@onready var starting_x: float = position.x
var bullet_dir = Vector2.RIGHT

func _physics_process(_delta: float) -> void:
	
	var player_sprite = $"../AnimatedSprite2D" 
	if player_sprite:
		if player_sprite.flip_h:
			
			bullet_dir = Vector2.LEFT
			position.x = -starting_x
			scale.x = -1
		else:
			bullet_dir = Vector2.RIGHT
			position.x = starting_x
			scale.x = 1
	
	
	#direction of bullet
	if Input.is_action_just_pressed("p" + str(parent.player_id) + "_shoot"):
		
		if $"../AnimatedSprite2D".flip_h:
			bullet_dir = Vector2.LEFT

		else:
			bullet_dir = Vector2.RIGHT

	
		shoot()
	

	



func shoot():
	if not bullet_scene: return # safety to stop crashing when debugging
	
	# make new bullet
	var new_bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(new_bullet)
	new_bullet.global_position = $MuzzlePoint.global_position
	new_bullet.direction = bullet_dir
