extends CharacterBody2D

const SPEED = 200.0*20
const JUMP_VELOCITY = -400.0

@onready var snd_walk = $Walk
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var active = false

signal posi(x)

func _physics_process(delta):
	# Add the gravity.
#	if not is_on_floor():
#		velocity.y += gravity * delta
#
#	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("key_left", "key_right")
	if direction && active:
		velocity.x = lerp(velocity.x, direction * SPEED, 0.25)#direction * SPEED
		emit_signal("posi",position.x)
		if !snd_walk.is_playing(): snd_walk.play()
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.25)
		move_toward(velocity.x, 0, SPEED)#
		snd_walk.stop()
	
	move_and_slide()
