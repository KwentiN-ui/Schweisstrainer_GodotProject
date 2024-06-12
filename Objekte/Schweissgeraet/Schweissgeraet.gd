extends Node3D
class_name Schweissmaschine

@export var halter:XRToolsPickable
var ui:Control
var display:Label 
var strom_ein:bool:
	set(neu_ein):
		strom_ein = neu_ein
		display.visible = strom_ein

var strom:int = 90:
	set(neuer_strom):
		strom = neuer_strom
		display.text = str(strom)+" A"
		
var spannung:float = 0
var abstand:float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	ui = $Bildschirm.scene_node
	assert(ui!=null,"UI konnte nicht importiert werden.")
	display = ui.find_child("Stromanzeige")
	display.text = str(ui.find_child("Stromslider").value)+" A"
	
	strom_ein = false
