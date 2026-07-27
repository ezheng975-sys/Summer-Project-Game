extends Node2D

#linking to the other scenes
@export var player_1: CharacterBody2D
@export var player_2: CharacterBody2D
@export var player_1_spawn: Marker2D
@export var player_2_spawn: Marker2D
@export var death_tp : Marker2D 


func _ready() -> void:
	GameManager.round_started.connect(round_start) # able to tell when round just started
	GameManager.player_died.connect(kill_player) # able to tell when player died
	
	if player_1: player_1.velocity = Vector2.ZERO # fix bug where player kept momentum after round end
	if player_2: player_2.velocity = Vector2.ZERO
	
	
	round_start()

func round_start():
	player_1.global_position = player_1_spawn.global_position
	player_2.global_position = player_2_spawn.global_position
	player_1.set_physics_process(true)
	player_2.set_physics_process(true)
	

	


func kill_player(player_id):
	get("player_" + str(player_id)).global_position = death_tp.global_position
	player_1.set_physics_process(false)
	player_2.set_physics_process(false)
	
