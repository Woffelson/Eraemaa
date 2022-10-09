extends Node2D

@onready var pleijer = $CharacterBody2d
@onready var para_bak = $ParallaxBackground
@onready var para_front = $ParallaxBackground2
@onready var lunta = $Lunta
@onready var lunta2 = $Lunta2
@onready var sade = $Sade
@onready var sade2 = $Sade2
@onready var rainloop = $Rainloop
@onready var rainloop2 = $Rainloop2
@onready var menu_gui = $CanvasLayer/Menu
const poronkusema = 8000
const TRA = 1000 #transition area
var pl_pos_x = 0
var etapit = null
var etappi_kpl = 13
var menu = true

func _ready():
	#pleijer.position.x = poronkusema *11
	lunta.position.x = poronkusema*8
	lunta2.position.x = -poronkusema*8
	sade.position.x = poronkusema*3.75
	sade2.position.x = -poronkusema*3.75
	rainloop.position.x = poronkusema*3.75
	rainloop2.position.x = -poronkusema*3.75
	etapit = range(poronkusema,poronkusema*etappi_kpl,poronkusema)
	pleijer.posi.connect(self.set_pl_pos)
	print(etapit)

func _process(_delta):
	if Input.is_action_just_pressed("any_key"):
		menu = !menu
		pleijer.active = !pleijer.active
		if menu: menu_gui.fade(1)
		else: menu_gui.fade(0)

func set_pl_pos(x): #value taken from signal
	pl_pos_x = x
	for etappi in etapit:
		var tsekpossi = abs(floor(pl_pos_x))
		if tsekpossi >= etappi:
			if tsekpossi <= etappi+TRA: #transition area
				between_prkl(etappi,tsekpossi)
			else: reuna_prkl(etappi)
		if tsekpossi > poronkusema*etappi_kpl:
			pleijer.position.x -= sign(pleijer.position.x)*8
			pleijer.position.x *= -1 #wrap around world

func between_prkl(etp,tsek):
	para_bak.nykyetappi = etp/poronkusema
	para_bak.pos_in_between = tsek-etp
	para_front.nykyetappi = etp/poronkusema
	para_front.pos_in_between = tsek-etp

func reuna_prkl(etp):
	para_bak.nykyetappi = etp/poronkusema
	para_bak.pos_in_between = etp+TRA
	para_front.nykyetappi = etp/poronkusema
	para_front.pos_in_between = etp+TRA
