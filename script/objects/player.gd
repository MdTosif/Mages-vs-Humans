extends KinematicBody2D

var velocity = Vector2.ZERO
var input_x = 0
var state = ""
onready var sprite = $AnimatedSprite
onready var player = $AnimationPlayer
onready var AtkPlayer = $sword/AnimationPlayer
export var speed = 100
export var jump : int
export var gravity_multiplier = 7
export var gravity = 5
export var friction = 60
export var acceleration = 100
export var jmp_acceleration : int

export var hp : int
export var maxHP : int


func _physics_process(delta):
	match state:
		"idle":
			apply_friction()
			player.play("idle")
		"walking":
			apply_acceleration(speed)
			player.play("walking")
			sprite.flip_h = input_x < 0
		"jumping":
			$jump.play()
			velocity.y = move_toward(0, -jump*100, 300)
		"attacking":
			AtkPlayer.play("attack")
				

	apply_gravity()
	sword_flip()
	healthBar_setup()
	velocity = move_and_slide(velocity,Vector2.UP)
	input_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if input_x == 0:
		state = "idle"
	else:
		state = "walking"

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		state = "jumping"


	if Input.is_action_just_pressed("ui_accept"):
		state = "attacking"

func healthBar_setup():
	$HUD/ProgressBar.max_value = maxHP
	$HUD/ProgressBar.value = hp
	if hp <= 0:
		$HUD/Popup.visible=true
		yield(get_tree().create_timer(1),"timeout")
		get_tree().change_scene("res://scenes/Menu.tscn")
		
	

func apply_gravity():
	velocity.y += gravity
	if velocity.y > 0:
		velocity.y += gravity_multiplier


func apply_friction():
	velocity.x = move_toward(velocity.x, 0, friction)


func apply_acceleration(amount):
	velocity.x = move_toward(0, input_x*amount, acceleration)

func sword_flip():
	if sprite.flip_h==true:
		$sword/AnimatedSprite.flip_h=true
		$sword/AnimatedSprite.offset.x = 0
		$sword.position.x = -50
	else:
		$sword/AnimatedSprite.flip_h=false
		$sword/AnimatedSprite.offset.x = -2
		$sword.position.x = 20


func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy"):
		hp -= body.damage

