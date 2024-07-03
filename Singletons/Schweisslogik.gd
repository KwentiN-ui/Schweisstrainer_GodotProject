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
var gezuendet = false:
	set(neu):
		gezuendet = neu
		if gezuendet:
			max_distanz = 0.08
		else:
			max_distanz = 0.01

var max_distanz = 0.01 #m
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

var root
var curr_scene: Node3D

func _ready():
	root = get_tree().root
	curr_scene = root.get_child(root.get_child_count()-1)
	halter["elektrode"] = curr_scene.find_child("Elektrode")

func _process(delta):
	t += delta
	var pfad:Path3D = halter["path3d"]
	#elektrode_l = randf_range(0.1,0.3)
	var ursprung_Elektrode = pfad.to_global(pfad.curve.get_point_position(0).lerp(pfad.curve.get_point_position(1),0.5))
	halter["elektrode"].global_position = ursprung_Elektrode
	halter["elektrode"].mesh.height = elektrode_l
	

func _physics_process(delta):
	raycast_schweissflaechen()
	abbrennen(delta)

func abbrennen(delta):
	if gezuendet and elektrode_l>0:
		elektrode_l -= strom * 0.00010 * delta # TODO Durch Funktion (d) ersetzen!
		print(strom,",",elektrode_l)
		
func raycast_schweissflaechen():
	# Geht durch alle Schweissflächen und Raycasted in der maximalen Länge des Lichtbogens

	var pfad:Path3D = halter["path3d"]
	var verfehlt = []
	for flaeche in schweissflaechen:
		if flaeche is Schweissflaeche: # könnte auch gelöscht worden sein, daher check
			var up_vector = flaeche.basis.y
			var space_state = curr_scene.get_world_3d().direct_space_state
			var ursprung_Elektrode = pfad.to_global(pfad.curve.get_point_position(1))
			var ziel = ursprung_Elektrode + max_distanz * -1*up_vector
			var query = PhysicsRayQueryParameters3D.create(ursprung_Elektrode, ziel)
			Draw3d.line(ursprung_Elektrode, ziel)
			var result = space_state.intersect_ray(query)

			if result.get("collider") is Schweissflaeche and result.get("collider") == flaeche: # hat der Raycast die Schweißfläche getroffen?
				verfehlt.append(false)
				if not gezuendet:
					# Lichtbogen zünden
					gezuendet = true
					return
				if gezuendet:
					# Naht erzeugen
					pass
			else:
				verfehlt.append(true)
	if verfehlt.all(is_true):
		gezuendet = false

func is_true(wert):
	return wert==true

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
