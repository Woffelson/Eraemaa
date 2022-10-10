extends "res://Paratrees.gd"

@onready var sky = $Sky
@onready var sky_blu = $Sky/Dark/bluu
@onready var sky_red = $Sky/Dark/red
@onready var sky_purpl = $Sky/Dark/purpl
@onready var dry = $Mountains/dry
@onready var snow = $Mountains/snow
@onready var ground = $Ground
@onready var st_stars = $Static/stars
@onready var st_minim = $Static/minim
@onready var st_qarska = $Static/qarska
@onready var st_valley = $Static/valley
@onready var rd_norm = $Road/normroad
@onready var rd_min = $Road/minroad
var sky_spede = -24

func _ready():
	tween_values = [Vector2(0.5,0.51),Vector2(0.5025,0.5)]
	tween = get_tree().create_tween()
	tween.tween_property(liivs, "scale", tween_values[0], 1.2).set_trans(Tween.TRANS_SINE)
	tween.tween_property(liivs, "scale", tween_values[1], 1.2).set_trans(Tween.TRANS_SINE)
	tween.set_loops(0)
	dry.set_self_modulate(Color(1,1,1,0))
	snow.set_self_modulate(Color(1,1,1,0))
	srunko.set_self_modulate(Color(1,1,1,0))
	sky_red.set_self_modulate(Color(1,1,1,0))
	sky_purpl.set_self_modulate(Color(1,1,1,0))
	st_stars.set_modulate(Color(1,1,1,0))
	st_minim.set_modulate(Color(1,1,1,0))
	st_qarska.set_modulate(Color(1,1,1,0))
	st_valley.set_modulate(Color(1,1,1,0))
	rd_min.set_modulate(Color(1,1,1,0))

func _process(delta):
#	if Input.is_action_just_pressed("ui_accept"):
#		print(sky_red.get_self_modulate())#Color(1,1,1,1))
#		print(pos_in_between)
	sky.motion_offset.x += sky_spede * delta
	if pos_in_between > 0:
		match (nykyetappi):
			#0: modulator_self(sky_red,-1)
			1: modulator_self(dry)
			2: modulator_self(sky_red)
			3: modulator(ground,-1)
			4: modulator_self(sky_blu,-1)
			5: modulator_self(liivs,-1)
			6:
				modulator(st_stars)
				modulator_self(snow)
			7: 
				modulator_self(dry,-1)
				#modulator_self(srunko)
				modulator_self(sky_purpl)
			8: 
				modulator_self(sky_red,-1)
				#modulator_self(runko,-1)
			9: modulator_self(sky_purpl,-1)
			10:
				shrink(runko)
				modulator(runko,-1)
				modulator(st_qarska)
				modulator(st_valley)
			11: modulator_self(snow,-1)
			12: 
				modulator(st_minim)
				modulator(rd_min)
				modulator(rd_norm,-1)
				modulator(st_qarska,-1)
				modulator(st_valley,-1)
				modulator(st_stars,-1)
