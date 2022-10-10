extends CharacterBody2D

const SPEED = 100.0#*20
const JUMP_VELOCITY = -400.0

@onready var snd_walk = $Walk
@onready var spr = $spr
@onready var kamera = $Camera2d
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var hor = 1
var active = false
var minim = false
var tween = null
var tween_values = [Vector2(1.1,1),Vector2(1,1.05)]

signal posi(x)

func _ready():
	tween = get_tree().create_tween()
	tween.tween_property(self, "scale", tween_values[0], 2).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "scale", tween_values[1], 2).set_trans(Tween.TRANS_SINE)
	tween.set_loops(0)

func _physics_process(_delta):
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
		velocity.x = lerp(velocity.x, (direction * max(1,abs(spr.frame-2)/1.25)) * SPEED , 0.1)#direction * SPEED
		emit_signal("posi",position.x)
		hor = direction
		if !snd_walk.is_playing(): snd_walk.play()
		if minim: spr.animation = "walk_b"
		else: spr.animation = "walk_a"
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.25)
		move_toward(velocity.x, 0, SPEED)#
		snd_walk.stop()
		if minim: spr.animation = "idle_b"
		else: spr.animation = "idle_a"
	spr.flip_h = bool(hor+1)
	
	move_and_slide()
