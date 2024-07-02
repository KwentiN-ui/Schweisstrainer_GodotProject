# Zentrale anlaufstelle für alles was mit dem Schweißvorgang zu tun hat.
# Die anderen Skripte schreiben ihre Daten hier rein und lesen sie hier aus.

extends Node

var schweissmaschine: Schweissmaschine

var halter = {
	"root":null,
	"path3d":null,
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

var elektrode_d = 0.04: #m Durchmesser
	set(neu):
		elektrode_d = neu

var elektrode_l = 0.3: #m Länge
	set(neu):
		elektrode_l = neu
		refresh_elektrodenpfad()

func _ready():
	pass

func _process(delta):
	t += delta
	elektrode_l = (sin(t)+1)/2 * 0.4

func refresh_elektrodenpfad():
	if is_instance_valid(halter["path3d"]) and is_instance_valid(halter["path3d"]):
		var pfad:Path3D = halter["path3d"]
		var curve:Curve3D = pfad.curve
		curve.set_point_position(1,Vector3(elektrode_l,0,0))

func kreisform_koordinaten(radius:float)->PackedVector2Array:
	var w = deg_to_rad(360/15.0)
	var punkte: PackedVector2Array
	for i in range(0,15):
		punkte.append(Vector2(cos(w*(i+1))*radius, sin(w*(i+1))*radius))
	return punkte
