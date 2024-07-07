@tool
extends StaticBody3D
class_name Schweissflaeche

var schweissbäder = []

@onready var kollision:CollisionShape3D
@onready var particle_kollision:GPUParticlesCollisionBox3D
@onready var mesh:MeshInstance3D

@export_category("Maße")
@export_range(1e-3,1,1e-3) var breite:float:
	set(neu):
		breite = neu
		if is_instance_valid(kollision) and is_instance_valid(particle_kollision) and is_instance_valid(mesh):
			kollision.shape.size.x = neu
			particle_kollision.size.x = neu
			mesh.mesh.size.x = neu

@export_range(1e-3,3,1e-3) var länge:float:
	set(neu):
		länge = neu
		if is_instance_valid(kollision) and is_instance_valid(particle_kollision) and is_instance_valid(mesh):
			kollision.shape.size.z = neu
			particle_kollision.size.z = neu
			mesh.mesh.size.y = neu

func _ready():
	kollision = find_child("CollisionShape3D",false)
	particle_kollision = find_child("GPUParticlesCollisionBox3D",false)
	mesh = find_child("MeshInstance3D",false)
	breite = breite
	länge = länge
	
	if !Engine.is_editor_hint():
		Schweisslogik.schweissflaechen.append(self)
