extends Node

var Sprechblasen_Scene: PackedScene
var sprechblase
var curr_scene = null
var label: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().root
	curr_scene = root.get_child(root.get_child_count()-1)
	Sprechblasen_Scene = preload("res://Objekte/Sprechblasen.tscn")


func add_dialogue(text_in:String):
	sprechblase = Sprechblasen_Scene.instantiate()
	curr_scene.find_child("Aufseher").add_child(sprechblase)
	label = sprechblase.find_child("Label")
	label.text = text_in

func close_dialogue():
	sprechblase.queue_free()
