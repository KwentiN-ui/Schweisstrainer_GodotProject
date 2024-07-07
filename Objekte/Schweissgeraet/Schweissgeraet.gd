extends Node3D
class_name Schweissmaschine

signal picked()

# Called when the node enters the scene tree for the first time.
func _ready():
	Schweisslogik.ui = $Bildschirm.scene_node
	Schweisslogik.halter["root"] = $Elektrodenhalter
	Schweisslogik.halter["path3d"] = $Elektrodenhalter/Path3D
	Schweisslogik.elektrode_d = 0

	Schweisslogik.stromdisplay = Schweisslogik.ui.find_child("Stromanzeige")
	Schweisslogik.stromdisplay.text = str(Schweisslogik.ui.find_child("Stromslider").value)+" A"


func _on_elektrodenhalter_picked_up(pickable):
	picked.emit() # Replace with function body.
