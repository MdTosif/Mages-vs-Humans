extends KinematicBody2D

var velocity = Vector2.ZERO
export var gravity : int
export var text : String
onready var dialogBox = $TextureRect
onready var label = $TextureRect/RichTextLabel

func _ready():
	label.text = text

func _physics_process(delta):
	gravity()
	velocity= move_and_slide(velocity,Vector2.UP)

func gravity():
	velocity.y += gravity


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		dialogBox.visible = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		dialogBox.visible = false
