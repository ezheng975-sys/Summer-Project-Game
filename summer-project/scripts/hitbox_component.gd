extends Area2D
class_name HitboxComponent

@export var damage: int = 10 # damage
var parent: Area2D = get_parent()


func _physics_process(delta: float) -> void:
	pass
	# remember to add everything to change the damage of the attack with different weapons using SIGNALLLS


func _on_area_entered(area: Area2D) -> void: # when entering hurtbox
	# possible animations
	queue_free()
