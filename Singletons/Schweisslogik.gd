# Zentrale anlaufstelle für alles was mit dem Schweißvorgang zu tun hat.
# Die anderen Skripte schreiben ihre Daten hier rein und lesen sie hier aus.

extends Node

var Lichtbogen_an = true # DEBUG für Nahterstellung

var schweissmaschine: Schweissmaschine
var Schachteln: Node3D
var elektroden_boxen: Array[StaticBody3D]

var halter = {
	"root":null,   # XRToolsPickable
	"path3d":null, # Path3D Node
	"elektrode":null, #MeshInstance3D
}

var spieler = {
	"root":null,
	"hand_r":null,
	"hand_l":null,
}

var schweissflaechen = []
var gezuendet = false:
	set(neu):
		gezuendet = neu
		if gezuendet && strom_ein:
			max_distanz = 0.08
			if Lichtbogen_an:
				lichtbogen.emitting = true
				LichtbogenLicht.visible = true
				funken.emitting = true
				if is_instance_valid(Helm_Visier):
					var Mat = StandardMaterial3D.new() 
					Mat.albedo_color = Color(0,0.5,0,0.98)
					Mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
					Mat.roughness = 0.6
					Helm_Visier.mesh.surface_set_material(0,Mat)
				if !Schweiss_Ton.playing:
					Schweiss_Ton.playing = true
		else:
			max_distanz = 0.01
			lichtbogen.emitting = false
			funken.emitting = false
			LichtbogenLicht.visible = false
			Schweiss_Ton.playing = false
			if is_instance_valid(Helm_Visier):
				var Mat = StandardMaterial3D.new() 
				Mat.albedo_color = Color(0,0.5,0,0.6)
				Mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
				Mat.roughness = 0.6
				Helm_Visier.mesh.surface_set_material(0,Mat)

var lichtbogen: GPUParticles3D
var LichtbogenLicht: OmniLight3D
var funken: GPUParticles3D
var Helm_Visier: MeshInstance3D
var Schweiss_Ton: AudioStreamPlayer3D


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

var elektrode_l = 0.008: #m Länge
	set(neu):
		elektrode_l = neu
		refresh_elektrodenpfad()

var root
var curr_scene: Node3D

func _ready():
	root = get_tree().root
	curr_scene = root.get_child(root.get_child_count()-1)
	halter["elektrode"] = curr_scene.find_child("Elektrode")
	lichtbogen = curr_scene.find_child("Lichtbogen")
	LichtbogenLicht = curr_scene.find_child("LichtbogenLicht")
	Helm_Visier = curr_scene.find_child("Visier")
	funken = curr_scene.find_child("Funken")
	Schweiss_Ton = curr_scene.find_child("Elektrode_ton")
	Schachteln = curr_scene.find_child("Schachteln")
	lichtbogen.emitting = false
	LichtbogenLicht.visible = false
	funken.emitting = false

func _process(delta):
	t += delta
	
	# Platziere die Elektrode mittig im Pfad
	var pfad:Path3D = halter["path3d"]
	var ursprung_Elektrode = pfad.to_global(pfad.curve.get_point_position(0).lerp(pfad.curve.get_point_position(1),0.5))
	halter["elektrode"].global_position = ursprung_Elektrode
	# Skaliere die Elektrode auf die aktuelle Länge
	halter["elektrode"].mesh.height = elektrode_l
	var ursprung_Lichtbogen = pfad.to_global(pfad.curve.get_point_position(1))
	lichtbogen.global_position = ursprung_Lichtbogen
	LichtbogenLicht.global_position = ursprung_Lichtbogen
	funken.global_position = ursprung_Lichtbogen
	

func _physics_process(delta):
	raycast_schweissflaechen()
	abbrennen(delta)

func abbrennen(delta):
	if gezuendet and elektrode_l>0:
		elektrode_l -= strom * 0.00010 * delta # TODO Durch Funktion (d) ersetzen!
		
func raycast_schweissflaechen():
	# Geht durch alle Schweissflächen und Raycasted in der maximalen Länge des Lichtbogens
	var pfad:Path3D = halter["path3d"]
	var verfehlt = []
	for flaeche in schweissflaechen:
		if flaeche is Schweissflaeche: # könnte auch gelöscht worden sein, daher check
			var up_vector = flaeche.global_basis.y
			var space_state = curr_scene.get_world_3d().direct_space_state
			var ursprung_Elektrode = pfad.to_global(pfad.curve.get_point_position(1))
			var ziel = ursprung_Elektrode + max_distanz * -1*up_vector
			var query = PhysicsRayQueryParameters3D.create(ursprung_Elektrode, ziel)
			var result = space_state.intersect_ray(query)
			# Richtung für Partikel definieren
			lichtbogen.process_material.direction = lichtbogen.to_local((ziel - ursprung_Elektrode).normalized())
			Draw3d.line(ursprung_Elektrode, ziel)

			if result.get("collider") is Schweissflaeche and result.get("collider") == flaeche: # hat der Raycast die Schweißfläche getroffen?
				verfehlt.append(false)
				if not gezuendet:
					# Lichtbogen zünden
					gezuendet = true
					return
				if gezuendet:
					# Naht erzeugen TODO
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
