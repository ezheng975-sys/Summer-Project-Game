extends Node
class_name HealthComponent

# signals
signal health_changed(new_health: int)
signal damage_taken(amount: int)
signal died(player_id: int)

# variables
@export var parent : CharacterBody2D
@export var max_health: int = 100


var current_health: int = max_health:
	set(value):
		current_health = clampi(value, 0, max_health) # clamp from 0 to max_health
		health_changed.emit(current_health)
		print(current_health)
		if current_health <= 0: # check death
			die()
		else:
			pass #stuff that happens if player took damage (reminder to code ui change here or use signal in ui)

func _ready():
	GameManager.round_started.connect(round_start)
	died.connect(GameManager._on_player_death)
	if not parent:
		parent = get_parent()
		
	
	
		
		
		
func die():
	died.emit(parent.player_id)
	
	
func take_damage(amount: int):

	current_health -= amount
	damage_taken.emit(amount)


	
	
func round_start():
	current_health = max_health

	
	
	
		
