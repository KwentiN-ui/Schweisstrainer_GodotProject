# Zentrale anlaufstelle für alles was mit dem Schweißvorgang zu tun hat.
# Die anderen Skripte schreiben ihre Daten hier rein und lesen sie hier aus.

extends Node

var schweissmaschine: Schweissmaschine

var halter = {
	"root":null,   # XRToolsPickable
	"path3d":null, # Path3D Node
	"querschnitt":null, # CSGPolygon3
}

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
	pass

func _process(delta):
	t += delta
	elektrode_l = (sin(t)+1)/2 * elektrode_l

func refresh_elektrodenpfad():
	if is_instance_valid(halter["path3d"]) and is_instance_valid(halter["path3d"]):
		var pfad:Path3D = halter["path3d"]
		var curve:Curve3D = pfad.curve
		curve.set_point_position(1,Vector3(elektrode_l,0,0))

func refresh_elektrodenquerschnitt():
	if is_instance_valid(halter["querschnitt"]):
		var qs:CSGPolygon3D = halter["querschnitt"]
		qs.polygon = kreisform_koordinaten(elektrode_d/2.0)


func kreisform_koordinaten(radius:float)->PackedVector2Array:
	var punkte = []
	for i in range(0,floor(2*PI*100),20):
		var w = i/100.0
		punkte.append(Vector2(radius*cos(w),radius*sin(w)))
	return punkte
