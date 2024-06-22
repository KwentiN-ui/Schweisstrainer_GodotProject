extends Node

var Sprechblasen_Scene: PackedScene
var sprechblase: Node3D
var curr_scene = null
var label: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().root
	curr_scene = root.get_child(root.get_child_count()-1)
	Sprechblasen_Scene = preload("res://Objekte/Sprechblasen.tscn")

func add_dialogue(parent:String,text_in:String, pos_zu_par:Vector3, min_width:int, min_height:int):
	sprechblase = Sprechblasen_Scene.instantiate()
	curr_scene.find_child(parent).add_child(sprechblase)
	sprechblase.position = pos_zu_par
	label = sprechblase.find_child("Label")
	label.text = text_in
	label.custom_minimum_size.x = min_width
	label.custom_minimum_size.y = min_height
	var vport:SubViewport = label.find_parent("SubViewport")
	vport.size.x = label.custom_minimum_size.x
	vport.size.y = label.custom_minimum_size.y

func close_dialogue(parent):
	var par = curr_scene.find_child(parent)
	for child in par.get_children():
		if child.name == "SPRECHBLASE":
			child.queue_free()
