extends MeshInstance3D
class_name Schweissbad
const min_temperatur = 700
const max_temperatur = 1800
const nahtabstände = 1e-3
var parent_fläche: Schweissflaeche
@export var farbe_kalt: Color
@export var farbe_warm: Color

# Speichert die Position des Bades um die Bewegungsrichtung als Differenz zu ermitteln
var last_saved_pos:Vector3
var last_tick_pos:Vector3
var geschwindigkeit:float

var nahtmaterial = StandardMaterial3D.new() # Material für Schweissnaht
var badmaterial = StandardMaterial3D.new()

var temperatur:float = min_temperatur*1.5:
	set(neu):
		temperatur = neu
		if temperatur>max_temperatur:
			temperatur = max_temperatur
		if temperatur < min_temperatur:
			if is_instance_valid(parent_fläche):
				parent_fläche.schweissbäder.erase(self)
			queue_free()
		else:
			durchmesser = lerpf(0,3e-2,(neu-min_temperatur)/2000)
			# Lege Material fest
			badmaterial.emission = farbe_kalt.lerp(farbe_warm,(temperatur-min_temperatur)/(max_temperatur-min_temperatur))


var durchmesser: float:
	set(neu):
		durchmesser = neu
		mesh.top_radius = neu/2.0
		mesh.bottom_radius = neu/2.0

func _ready():
	durchmesser = 0.1
	last_saved_pos = position
	last_tick_pos = position
	
	# Badmaterialdaten
	badmaterial.emission_enabled = true
	badmaterial.emission_energy_multiplier = 5
	badmaterial.roughness = 0
	badmaterial.albedo_color = Color(255,0,0)
	mesh.surface_set_material(0,badmaterial)
	
	# Schweissnahtnahtmaterial
	nahtmaterial.albedo_color = Color(0.7,0.7,0.7)
	nahtmaterial.roughness = .6
	nahtmaterial.metallic = 1
	nahtmaterial.metallic_specular = 0.8

func _physics_process(delta):
	temperatur -= temperatur**2.1*1e-6
	geschwindigkeit = ((position - last_tick_pos) * delta * 1e6).length()
	if last_saved_pos.distance_to(position) > nahtabstände:
		var bewegungsrichtung:Vector3 = last_saved_pos - position
		var nahtabschnitt:Node3D = Schweisslogik.nähte.pick_random().instantiate()
		parent_fläche.add_child(nahtabschnitt)
		
		# Transformation
		nahtabschnitt.position = parent_fläche.to_local(global_position)
		nahtabschnitt.global_basis = Basis(
			parent_fläche.global_basis.y.cross(-bewegungsrichtung), # X über Kreuzprodukt von Oben und Vorne
			parent_fläche.global_basis.y,
			-bewegungsrichtung
			).orthonormalized()
		nahtabschnitt.scale = 1.0/sqrt(clampf(geschwindigkeit,1,100)) * durchmesser * 40.0 * Vector3(1,1,1) # empirischer Skalierungsfaktor in Abhängigkeit des Baddurchmessers
		nahtabschnitt.find_child("Icosphere_003",false).mesh.surface_set_material(0, nahtmaterial)
		last_saved_pos = position
	last_tick_pos = position
