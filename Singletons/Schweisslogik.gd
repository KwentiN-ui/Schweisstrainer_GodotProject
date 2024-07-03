# Zentrale anlaufstelle für alles was mit dem Schweißvorgang zu tun hat.
# Die anderen Skripte schreiben ihre Daten hier rein und lesen sie hier aus.

extends Node

var schweissmaschine: Schweissmaschine

var halter = {
	"root":null,   # XRToolsPickable
	"path3d":null, # Path3D Node
	"elektrode":null, #MeshInstance3D
}

var schweissflaechen = []

var t = 0.0
var stromdisplay: Label
var ui:Control
var strom_ein:bool = false:
	set(neuer_wert):
		strom_ein = neuer_wert
		stromdisplay.visible = strom_ein

var strom:int = 0:
	set(neuer_strom):
		strom = neuer_strom
		if is_instance_valid(stromdisplay):
			stromdisplay.text = str(strom)+" A"

var elektrode_d: #m Durchmesser, Startwert wird in der Schweißmaschine festgelegt
	set(neu):
		elektrode_d = neu
		refresh_elektrodenquerschnitt()

var elektrode_l = 0.3: #m Länge
	set(neu):
		elektrode_l = neu
		refresh_elektrodenpfad()

func _ready():
	var root = get_tree().root
	var curr_scene = root.get_child(root.get_child_count()-1)
	halter["elektrode"] = curr_scene.find_child("Elektrode")

func _process(delta):
	t += delta
	var pfad:Path3D = halter["path3d"]
	elektrode_l = randf_range(0.1,0.3)
	var ursprung_Elektrode = pfad.to_global(pfad.curve.get_point_position(0).lerp(pfad.curve.get_point_position(1),0.5))
	halter["elektrode"].global_position = ursprung_Elektrode
	halter["elektrode"].mesh.height = elektrode_l
	
	raycast_schweissflaechen()

func raycast_schweissflaechen() -> Array:

	for flaeche in schweissflaechen:
		if flaeche is Schweissflaeche:
			var up_vector = flaeche.basis.y
			print(flaeche,up_vector)
	return []

func refresh_elektrodenpfad():
	var pfad:Path3D = halter["path3d"]
	if is_instance_valid(pfad):
		var curve:Curve3D = pfad.curve
		curve.clear_points()
		curve.add_point(Vector3(0,0,0))
		curve.add_point(Vector3(elektrode_l,0,0))

func refresh_elektrodenquerschnitt():
	halter["elektrode"].mesh.top_radius = elektrode_d/2
	halter["elektrode"].mesh.bottom_radius = elektrode_d/2
