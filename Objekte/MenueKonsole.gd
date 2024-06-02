extends Node3D

@onready var gui:Control = get_node("SubViewport/GUI")
@onready var current_focus: Control
@onready var current_focus_index := 0:
	set(new_focus):
		current_focus_index = clamp(current_focus_index,0,len(level)-1)
		current_focus_index = new_focus
		current_focus = level[new_focus]

var levelnamen = ["Menu","Kap1","Kap2","Kap3"]
var level = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for lvlname in levelnamen:
		level.append(gui.find_child(lvlname))
	print(level)

func _on_hoch_knopf_pressed():
	current_focus_index += 1
	print(current_focus)

func _on_runter_knopf_pressed():
	current_focus_index -= 1
	print(current_focus)

func _on_start_knopf_pressed():
	pass
