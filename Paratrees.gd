extends ParallaxBackground

@onready var runko = $Trees/runko
@onready var liivs = $Trees/liivs

const TRA = 1000 #transition area
var nykyetappi = 0
var pos_in_between = 0
var tween = null
var tween_values = [Vector2(0.705,0.7),Vector2(0.7,0.72)]

func _ready():
	tween = get_tree().create_tween()
	tween.tween_property(liivs, "scale", tween_values[0], 1).set_trans(Tween.TRANS_SINE)
	tween.tween_property(liivs, "scale", tween_values[1], 1).set_trans(Tween.TRANS_SINE)
	tween.set_loops(0)

func _process(_delta):
	if pos_in_between > 0:
		match (nykyetappi):
			5: modulator_self(liivs,-1)
			10:
				shrink(runko)
				modulator_self(runko,-1)

func modulator_self(item,appear:=1):#-1 actually disappears (1 appears)
	var c = Color(1,1,1,sign((abs(appear-1)))+appear*(min(TRA,pos_in_between)/TRA))
	item.set_self_modulate(c)

func shrink(item):
	item.offset.y = ceil(pos_in_between)*2

func modulator(item,appear:=1):#-1 actually disappears (1 appears)
	item.set_modulate(Color(1,1,1,sign((abs(appear-1)))+appear*(min(TRA,pos_in_between)/TRA)))
