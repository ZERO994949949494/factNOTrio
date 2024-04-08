extends CharacterBody2D


@export var MAX_SPEED = 50
@export var ACCELERATION = 100
@export var FRICTION = 1200

@onready var Axis= Vector2.ZERO
@onready var meow= "0-1"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Move(delta)
	if Axis!=Vector2.ZERO:
		$Sprite2D/AnimationPlayer.play(meow)
	else:
		$Sprite2D/AnimationPlayer.stop()
		match meow:
			"0-1":
				$Sprite2D.set_frame(8)
			"01":
				$Sprite2D.set_frame(12)
			"-10":
				$Sprite2D.set_frame(14)
			"10":
				$Sprite2D.set_frame(10)
			"-1-1":
				$Sprite2D.set_frame(15)
			"11":
				$Sprite2D.set_frame(11)
			"-11":
				$Sprite2D.set_frame(13)
			"1-1":
				$Sprite2D.set_frame(9)
		$Sprite2D.set_offset(Vector2(0,-2))
func get_input_axis():
	Axis.x=int(Input.is_action_pressed("RIGHT"))-int(Input.is_action_pressed("LEFT"))
	Axis.y=int(Input.is_action_pressed("DOWN"))-int(Input.is_action_pressed("UP"))
	return Axis.normalized()
func Move(delta):
	Axis=get_input_axis()
	if Axis==Vector2.ZERO:
		apply_friction(FRICTION*delta)
	else:
		apply_movement(Axis*ACCELERATION*delta)
		meow=str(round(Axis.x))+str(round(Axis.y))
	move_and_slide()
func apply_movement(accel):
	velocity+=accel
	velocity=velocity.limit_length(MAX_SPEED)
func apply_friction(amount):
	if Axis.length()>amount:
		velocity-=velocity.normalized() * amount
	else:
		velocity=Vector2.ZERO
