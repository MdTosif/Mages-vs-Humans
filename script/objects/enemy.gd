extends KinematicBody2D

var direction = 1
var velocity = Vector2.ZERO
export var gravity : int
export var speed = 50
onready var edgeLeft = $edgeCheckerLeft
onready var edgeRight = $edgeCheckerRight
onready var sprite = $AnimatedSprite

export var damage : int

func _physics_process(delta):
	gravity()
	flip()
	velocity.x = direction*speed
	velocity= move_and_slide(velocity,Vector2.UP)

func gravity():
	velocity.y += gravity

func flip():
	var isWall = is_on_wall()
	var isAir = not edgeRight.is_colliding() or not edgeLeft.is_colliding()

	if (isAir or isWall):
		direction *= -1
	if (not is_on_floor()):
		direction=1

	if direction<0:
		sprite.flip_h=true
	else:
		sprite.flip_h=false

func _on_Area2D_area_entered(area):
	if area.is_in_group("sword"):
		self.queue_free()
