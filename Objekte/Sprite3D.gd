extends Sprite3D

var Spieler: XRCamera3D

# Called when the node enters the scene tree for the first time.
func _ready():
	Spieler = find_parent("Main").find_child("XRCamera3D")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(Spieler.global_position)
	global_rotation.x = 0
	global_rotation.z = 0
