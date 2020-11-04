extends Node

#Add a script to Main. At the top of the script, we use 
#export (PackedScene) to allow us to choose the Mob scene we want to instance.
export (PackedScene) var Enemy
var score
var is_touch:bool

func _ready():
	randomize()


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_gameover()
	get_tree().call_group("mobs","queue_free")
	$BGM.stop()
	$DeathSound.play()
	pass

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$BGM.play()
	if $"HUD/Touch?".pressed == true:
		
		pass
	pass


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	pass 

func _on_ScoreTimer_timeout():
	score+=1
	$HUD.update_score(score)
	pass 

func _on_MobTimer_timeout():
	#Select random location to spawn mob along line
	$MobPath/MobSpawnLocation.offset = randi()
	
	#Instance code
	var enemy = Enemy.instance()
	add_child(enemy)
	
	#Sets the mob direction to it's perpendicular
	var direction = $MobPath/MobSpawnLocation.rotation + PI/2
	
	#Sets enemy position to the randomized path position
	enemy.position = $MobPath/MobSpawnLocation.position
	
	#"More randomness" by adding a random angle to the 
	#and setting mob direction
	direction += rand_range(-PI/4,PI/4)
	enemy.rotation = direction
	
	#idk dont ask
	enemy.linear_velocity = Vector2(rand_range(enemy.max_speed,enemy.min_speed),0)
	enemy.linear_velocity = enemy.linear_velocity.rotated(direction)
	
	pass




