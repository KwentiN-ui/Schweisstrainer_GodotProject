extends RayCast3D

const max_abstand = 1
signal nahtpunkt_erzeugen(pos:Vector3,normale:Vector3)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta):
	#var space_state = get_world_3d().direct_space_state
	#var origin = global_position
	#var richtung = global_transform.basis * Vector3(max_abstand,0,0)
	#var ziel = origin + richtung
	#$zielmesh.global_position = ziel
	#
	#var query = PhysicsRayQueryParameters3D.create(origin, ziel)
	#var result = space_state.intersect_ray(query)
	#print(result.values())
