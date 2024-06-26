extends ShapeCast3D

const max_abstand = 1
signal nahtpunkt_erzeugen(pos:Vector3,normale:Vector3)
var Kollisionsobjekte: Array[Object]

var schweissgeraet: Schweissmaschine


# Called when the node enters the scene tree for the first time.
func _ready():
	schweissgeraet = find_parent("Schweissgeraet")




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	shape.height = schweissgeraet.abstand
	shape.radius = schweissgeraet.elektrodendurchmesser/2
	for i in get_collision_count():
		Kollisionsobjekte.push_back(get_collider(i))
	#print(Kollisionsobjekte)
	
	for k in Kollisionsobjekte:
		for c in k.get_children():
			#print(c.name, "  :",type_string(c))
			if c.name == "schweissbar" && schweissgeraet.strom_ein:
				print("Schweißen")
	
	Kollisionsobjekte.clear()


