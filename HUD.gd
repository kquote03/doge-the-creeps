extends CanvasLayer

signal start_game

func show_message(message_text):
	$Message.text = message_text
	$Message.show()
	$MessageTimer.start()
	pass

func show_gameover():
	show_message("Game Over")
	
	#waits until messagetimer is done
	yield($MessageTimer,"timeout")
	
	$Message.text="Dodge The Creeps!!"
	$Message.show()
	
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1),"timeout")
	$StartButton.show()
	
	pass

func update_score(score):
	$ScoreLabel.text = str(score)


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
	pass


func _on_MessageTimer_timeout():
	$Message.hide()
	pass
