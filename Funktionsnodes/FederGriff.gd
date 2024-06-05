extends Node3D
@export var zielobjekt: RigidBody3D
@export var federkonstante:float = 1
var delta_vektor:Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	zielobjekt.global_position = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if zielobjekt != null:
		zielobjekt.global_rotation = global_rotation
		delta_vektor = zielobjekt.global_position - global_position
		zielobjekt.apply_central_force(-delta_vektor*federkonstante)
