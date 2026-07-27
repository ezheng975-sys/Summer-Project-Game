extends Node

signal round_started
signal player_died(player_id)

var round_target: int = 7
var current_round: int = 0
var p1_rounds_won: int = 0
var p2_rounds_won: int = 0



func _ready():
	round_start()

	
#func _physics_process(delta: float) -> void:
	# might need this later

func round_end():
	if p1_rounds_won == round_target:
		game_end(1)
	elif p2_rounds_won == round_target:
		game_end(2)
	
	else:
		#end of round stuff
		round_start() # reminder to cut this out for another function that transitions between rounds
						# and then move it to the end of that function
	



func round_start():
	current_round += 1
	round_started.emit()
		
	


func _on_player_death(player_id):
	player_died.emit(player_id)
	if player_id == 1:
		p2_rounds_won += 1
	elif player_id == 2:
		p1_rounds_won += 1
	else: return
	round_end()
	
	print("1: ", p1_rounds_won)
	print("2: ", p2_rounds_won)
	print(current_round)
	

	
	
func game_end(winning_player_id):
	if winning_player_id == 1:
		pass
	elif winning_player_id == 2:
		pass 
	




#music
#scene transitions
#event handling
