extends MeshInstance3D
class_name Schweissbad
const min_temperatur = 150
const max_temperatur = 1700
var parent_fläche: Schweissflaeche

var ueber_schmelztemp: bool = false

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
var durchmesser: float:
	set(neu):
		durchmesser = neu
		mesh.top_radius = neu/2.0
		mesh.bottom_radius = neu/2.0

func _ready():
	durchmesser = 0.1

func _physics_process(delta):
	temperatur -= temperatur**2*1e-6
	var Mat = StandardMaterial3D.new()
	Mat.emission_enabled = true 
	Mat.emission_energy_multiplier = 30
	Mat.roughness = 0
	if temperatur < 550:
		Mat.emission = Color(0.2,0.1,0)
	elif temperatur < 630:
		Mat.emission = Color(0.329,0.156,0.01)
	elif temperatur < 740:
		Mat.emission = Color(0.4,0.06,0)
	elif temperatur < 780:
		Mat.emission = Color(0.7,0,0)
	elif temperatur < 810:
		Mat.emission = Color(0.75,0.1,0.1)
	elif temperatur < 850:
		Mat.emission = Color(0.83,0.259,0.08)
	elif temperatur < 900:
		Mat.emission = Color(0.913,0.345,0.17)
	elif temperatur < 1000:
		Mat.emission = Color(1,0.6,0.05)
	elif temperatur < 1100:
		Mat.emission = Color(1,0.75,0.2)
	elif temperatur < 1200:
		Mat.emission = Color(1,0.8,0.38)
	elif temperatur < 1300:
		Mat.emission = Color(1,0.8,0.3)
	elif temperatur < 1300:
		Mat.emission = Color(1,0.9,0.6)
	else:
		Mat.emission = Color(1,1,1)
	Mat.albedo_color = Color(0,0,0)
	mesh.surface_set_material(0,Mat)
