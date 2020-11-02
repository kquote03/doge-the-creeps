extends RigidBody2D

export var min_speed = 150
export var max_speed = 250
var count=0 

func _ready():
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	$VisibilityNotifier2D.connect("screen_exited",self,"_on_Visibility2D_Screen_exited")

func _on_Visibility2D_Screen_exited():
	queue_free()

func _process(delta):
	pass
