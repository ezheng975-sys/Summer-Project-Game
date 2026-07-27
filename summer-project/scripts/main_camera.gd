extends Camera2D

@export var player_1: CharacterBody2D
@export var player_2: CharacterBody2D
@export var max_zoom: float = 1.7
@export var zoom_speed: float = 0.05
@export var margin: Vector2 = Vector2(300, 200)

func _ready() -> void:
	enabled = true

func _physics_process(_delta: float) -> void:
	global_position = (player_1.global_position + player_2.global_position) / 2.0
	update_zoom()
	
func update_zoom() -> void:
	#distance
	var distance_x = abs(player_1.global_position.x - player_2.global_position.x) + margin.x
	var distance_y = abs(player_1.global_position.y - player_2.global_position.y) + margin.y
	
	var screen = get_viewport_rect().size
	var target_factor = min(screen.x / distance_x, screen.y / distance_y, max_zoom)
	
	#smooth
	zoom = zoom.lerp(Vector2(target_factor, target_factor), zoom_speed)
