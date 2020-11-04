extends Area2D

signal hit

export var speed = 400
var screen_size
var touch_enabled 
var target = Vector2()

func _ready():
	screen_size=get_viewport_rect().size
	connect("body_entered",self,"_on_Body_entered")
	hide()
	pass

func _process(delta):
	
	var velocity = Vector2()
	
	if touch_enabled == false:
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
		if Input.is_action_pressed("ui_down"):
			velocity.y += 1
		if Input.is_action_pressed("ui_up"):
			velocity.y -= 1
	else:
		if position.distance_to(target) > 10:
			velocity = target - position
		pass

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		# See the note below about boolean assignment
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func _input(event):
	if touch_enabled == true:
		if event is InputEventScreenTouch and event.pressed:
			target = event.position

func _on_Body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled",true)

func start(pos):
	position = pos
	target = pos
	touch_enabled = $"../HUD/Touch?".pressed
	show()
	$CollisionShape2D.disabled = false


