extends MeshInstance3D
class_name Schweissbad
const min_temperatur = 700
const max_temperatur = 1800
var parent_fläche: Schweissflaeche
@export var farbe_kalt: Color
@export var farbe_warm: Color

# Speichert die Position des Bades vom letzten Tick um die Bewegungsrichtung als Differenz zu ermitteln
var last_pos:Vector3

var temperatur:float = min_temperatur*1.5:
	set(neu):
		temperatur = neu
		if temperatur>max_temperatur:
			temperatur = max_temperatur
		$Label3D.text = str(neu)
		if temperatur < min_temperatur:
			if is_instance_valid(parent_fläche):
				parent_fläche.schweissbäder.erase(self)
			queue_free()
		else:
			durchmesser = lerpf(0,3e-2,(neu-min_temperatur)/2000)
			# Lege Material fest
			var Mat = StandardMaterial3D.new()
			Mat.emission_enabled = true 
			Mat.emission_energy_multiplier = 5
			Mat.roughness = 0
			Mat.emission = farbe_kalt.lerp(farbe_warm,(temperatur-min_temperatur)/(max_temperatur-min_temperatur))
			Mat.albedo_color = Color(255,0,0)
			mesh.surface_set_material(0,Mat)
var durchmesser: float:
	set(neu):
		durchmesser = neu
		mesh.top_radius = neu/2.0
		mesh.bottom_radius = neu/2.0

func _ready():
	durchmesser = 0.1

func _physics_process(delta):
	temperatur -= temperatur**2.1*1e-6
