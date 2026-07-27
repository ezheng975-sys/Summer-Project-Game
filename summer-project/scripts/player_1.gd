extends CharacterBody2D
class_name Players

@export var player_id: int 
@export var death_tp: Marker2D

func _ready() -> void:
	if player_id:
		$AnimatedSprite2D.flip_h = bool(player_id - 1)
	

func _physics_process(delta: float) -> void:
	pass

	
