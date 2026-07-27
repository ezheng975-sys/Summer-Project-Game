extends Area2D
class_name HurtboxComponent

@export var health_component: HealthComponent #linking (reminder to change in inspector if code changes)


func _physics_process(delta: float) -> void:
	#also 60 times / second of the player existing to avoid SIGNAALLLLS
	pass


func _on_area_entered(area: Area2D) -> void: # when overlapping with bullet
	if area is HitboxComponent:
		health_component.take_damage(int(area.damage))
		area.get_parent().queue_free() # removes hitbox parent which is bullet
		
