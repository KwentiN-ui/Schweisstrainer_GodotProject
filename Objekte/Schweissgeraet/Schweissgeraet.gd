extends Node3D
class_name Schweissmaschine

@export var halter:XRToolsPickable

var csg_poly: CSGPolygon3D
var pfad: Path3D

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

var elektrodendurchmesser: float = 0.04

var elektroden_laenge: float = 0.3
var curr_scene: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pfad = find_child("Path3D")
	ui = $Bildschirm.scene_node
	assert(ui!=null,"UI konnte nicht importiert werden.")
	display = ui.find_child("Stromanzeige")
	display.text = str(ui.find_child("Stromslider").value)+" A"

	strom_ein = false
	
	csg_poly = CSGPolygon3D.new()
	csg_poly.mode = CSGPolygon3D.MODE_PATH
	csg_poly.path_node = "Elektrodenhalter/Path3D"

	var root = get_tree().root
	curr_scene = root.get_child(root.get_child_count()-1)

func pfad_punkte():
	pfad.curve.clear_points()
	pfad.curve.add_point(Vector3.ZERO)
	pfad.curve.add_point(Vector3(0.3,0,0))


func _physics_process(delta):
	pfad_punkte()
	elektrodenform()


func elektrodenform():
	var w = deg_to_rad(360/15)
	var punkte: PackedVector2Array
	for i in range(0,15):
		punkte.append(Vector2(cos(w*(i+1))*elektrodendurchmesser, sin(w*(i+1))*elektrodendurchmesser))

	csg_poly.polygon = punkte

