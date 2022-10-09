extends MarginContainer

var tween = null

func _ready():
	pass#fade(1)

func fade(alpha):
	tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,alpha), 2).set_trans(Tween.TRANS_SINE)
