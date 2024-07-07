extends MeshInstance3D
class_name Schweissbad
const min_temperatur = 150
const max_temperatur = 3000
var parent_fläche: Schweissflaeche
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
