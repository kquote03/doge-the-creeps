extends Node

#Add a script to Main. At the top of the script, we use 
#export (PackedScene) to allow us to choose the Mob scene we want to instance.
export (PackedScene) var Enemy
var score

func _ready():
	randomize()
