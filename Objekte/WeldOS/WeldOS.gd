extends Control
var aktuelle_szene: Control:
	set(neue_szene):
		aktuelle_szene = neue_szene
		reload_gui()
@export var Packed_Menu_Szene: PackedScene
@export var Packed_Schweiss_Szene: PackedScene
var menu_szene:Control
var schweiss_szene:Control

func _ready():
	instantiate_packed_scenes()
	aktuelle_szene = menu_szene
func instantiate_packed_scenes():
	menu_szene = Packed_Menu_Szene.instantiate()

func reload_gui():
	for n in get_children():
		remove_child(n)
		n.queue_free()
	instantiate_packed_scenes()
	add_child(aktuelle_szene)

