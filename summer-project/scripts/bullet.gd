extends Area2D
class_name Bullet

@export var speed: float = 600
var direction: Vector2 = Vector2.RIGHT

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	GameManager.round_started.connect(round_start)
	


func _physics_process(delta: float) -> void:
	
	# reminder to spawn in at muzzle point when shoot pressed
	position += direction * speed * delta
	
	
	if direction.x != 0:
		$AnimatedSprite2D.flip_h = (direction.x < 0)
	
	
func _on_body_entered(body: Node2D) -> void:
	pass
	queue_free()
	return

	# wall
	destroy()
	
func destroy():
	# animations
	queue_free()
# reminder to use signals in tab

func round_start():
	queue_free() # clears all bullets when round starts
