extends Node3D
class_name Schweissmaschine

@export var halter:XRToolsPickable

var csg_poly: CSGPolygon3D

var ui:Control
var display:Label 
var strom_ein:bool:
	set(neu_ein):
		strom_ein = neu_ein
		display.visible = strom_ein

var strom:int = 90:
	set(neuer_strom):
		strom = neuer_strom
		display.text = str(strom)+" A"
		
var spannung:float = 0
var abstand:float = 0

var elektrodendurchmesser: float

var elektroden_laenge: float

# Called when the node enters the scene tree for the first time.
func _ready():
	csg_poly = find_child("CSGPolygon3D")
	ui = $Bildschirm.scene_node
	assert(ui!=null,"UI konnte nicht importiert werden.")
	display = ui.find_child("Stromanzeige")
	display.text = str(ui.find_child("Stromslider").value)+" A"
	
	strom_ein = false

func _physics_process(delta):
	elektrodenform()

func elektrodenform():
	var w = deg_to_rad(360/25)
	var punkte: PackedVector2Array
	for i in range(0,25):
		punkte.append(Vector2(cos(w*(i+1))*elektrodendurchmesser, sin(w*(i+1))*elektrodendurchmesser))
	csg_poly.polygon = punkte
