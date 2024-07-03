extends Node3D

var Schachtel_1 : RigidBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
	Schachtel_1 = $E_1_2_300


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(Schachtel_1.get_colliding_bodies())
