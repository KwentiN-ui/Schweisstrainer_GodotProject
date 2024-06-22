extends Node

var Aufseher: Node3D
var curr_scene
var anim_player: AnimationPlayer
var anim_active:bool = false

func _ready():
	var root = get_tree().root
	curr_scene = root.get_child(root.get_child_count()-1)
	Aufseher = curr_scene.find_child("Aufseher")
	anim_player = Aufseher.find_child("AnimationPlayer")
	
func freuen():
	anim_player.play("Freuen")

func wuetend():
	anim_player.play("ArmatureAction")

func fertig():
	anim_player.play("stehen")
