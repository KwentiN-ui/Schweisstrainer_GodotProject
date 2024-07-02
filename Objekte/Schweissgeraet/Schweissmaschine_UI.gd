extends Control
var schweissmaschine:Schweissmaschine

# Called when the node enters the scene tree for the first time.
func _ready():
	schweissmaschine = find_parent("Schweissgeraet")
	assert(schweissmaschine!=null,"UI konnte Schweißmaschine nicht finden. Wurde die richtige Szene ausgeführt?")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_v_slider_value_changed(value):
	Schweisslogik.strom = value



func _on_einschalter_toggled(toggled_on):
	Schweisslogik.strom_ein = toggled_on
