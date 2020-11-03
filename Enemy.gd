extends RigidBody2D

export var min_speed = 150
export var max_speed = 250
var count=0
var mob_index

func _ready():
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	mob_index=randi() % mob_types.size()
	$AnimatedSprite.animation = mob_types[mob_index]
	if mob_index == 0:
		$CollisionShape2D.scale.x = $CollisionShape2D.scale.x * 0.8
		$CollisionShape2D.scale.y = $CollisionShape2D.scale.y * 0.8
		
	$VisibilityNotifier2D.connect("screen_exited",self,"_on_Visibility2D_Screen_exited")

func _on_Visibility2D_Screen_exited():
	queue_free()

func _process(delta):
	pass
