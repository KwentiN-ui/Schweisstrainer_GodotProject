extends Node

var Text: Dictionary = {
		"Einleitung" : 
			{
			"Inhalt": 
				"[p][font_size={30}]Willkommen![/font_size][/p]
				[p]In dieser virtuellen Werkstatt kann das  Schweißverfahren Lichtbogenhandschweißen erlernt oder geübt werden.[/p]",
			"Parent" : "Aufseher",
			"pos" : Vector3(-2.2,0.5,0),
			"min_w_h" : [300,300] # min width, heigth
			},
		"Teleportieren" : 
			{
			"Inhalt" :
				"[p]Zum  Teleportieren den \"A\" Knopf am rechten Controller drücken und auf den Zielort zeigen.[/p]
				[p][img=270]res://Bilder/fuer_Text/A_Knopf.png[/img][/p]",
			"Parent" : "Aufseher",
			"pos" : Vector3(-2.2,0.5,0),
			"min_w_h" : [300,300]
			},
		"Drehen" : 
			{
			"Inhalt" : 
				"[p]Zum Drehen den Joystick des rechten Controllers benutzen.[/p]
				[p][img=300]res://Bilder/fuer_Text/Joystick.png[/img][/p]",
			"Parent" : "Aufseher",
			"pos" : Vector3(-2.2,0.5,0),
			"min_w_h" : [300,300]
			},
		"Grip" : 
			{
			"Inhalt" : 
				"[p]Zum Greifen von Objekten \"Grip-Button\" drücken.[/p]
				[p][img=250]res://Bilder/fuer_Text/Grip.png[/img][/p]",
			"Parent" : "Aufseher",
			"pos" : Vector3(-2.2,0.5,0),
			"min_w_h" : [300,300]
			},
		"Trigger" : 
			{
			"Inhalt" : 
				"[p]Um Knöpfe zu drücken oder den Schweißhelm herunter- oder hoch zu klappen den \"Trigger-Button\" benutzen.[/p]
				[p][img=100]res://Bilder/fuer_Text/Trigger.png[/img][/p]",
			"Parent" : "Aufseher",
			"pos" : Vector3(-2.2,0.5,0),
			"min_w_h" : [300,300]
			},
		"Helm aufsetzen" : 
			{
			"Inhalt" : 
				"Um Augenverletzungen beim Schweißen zu vermeiden bitte den Schweißhelm greifen und aufsetzen.",
			"Parent" : "Aufseher",
			"pos" : Vector3(-2.2,0.5,0),
			"min_w_h" : [300,300]
			},
		"Helm Position" : 
			{
			"Inhalt" : 
				"[pulse][p align=center][color=red]Schweißhelm[/color][/p]
				[p align=center][font_size=40]\u2193[/font_size][/p]",
			"Parent" : "Helm_aufnehmen",
			"pos" : Vector3(0,0,-0.4),
			"min_w_h" : [200,200]
			}
		}

var Zeit_Einleitung = 15 #Sekunden

var Sprechblasen_Scene: PackedScene
var sprechblase: Node3D
var curr_scene = null
var label: RichTextLabel

var ControllerL: XRController3D
var ControllerR: XRController3D

var Einleitung_fertig: bool = false
var Einleitung_eingeblendet: bool = false
var eingeblendet: Dictionary = {
	"Grip" : false,
	"Trigger" : false,
	"Teleportieren" : false,
	"Drehen" : false,
}
var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().root
	curr_scene = root.get_child(root.get_child_count()-1)
	Sprechblasen_Scene = preload("res://Objekte/Sprechblasen.tscn")
	ControllerL = curr_scene.find_child("LinkerController")
	ControllerR = curr_scene.find_child("RechterController")
	add_dialogue("Einleitung")
	Einleitung_eingeblendet = true
	
	
func _process(delta):
	if !Einleitung_fertig:
		time += delta
	if time >= Zeit_Einleitung && !Einleitung_fertig:
		Einleitung_fertig = true
	if Einleitung_fertig && Einleitung_eingeblendet:
		close_dialogue("Einleitung")
		Einleitung_eingeblendet = false
		
	if !Einleitung_eingeblendet && !eingeblendet["Grip"]:
		add_dialogue("Grip")
		eingeblendet["Grip"] = true
	print(ControllerR.is_button_pressed("grip"),",",!Einleitung_eingeblendet,",",eingeblendet["Grip"])
	if !Einleitung_eingeblendet && eingeblendet["Grip"] && (ControllerR.is_button_pressed("Grip") || ControllerL.is_button_pressed("Grip")) :
		close_dialogue("Grip")


func add_dialogue(line:String):
	var text_in = Text[line]["Inhalt"]
	sprechblase = Sprechblasen_Scene.instantiate()
	curr_scene.find_child(Text[line]["Parent"]).add_child(sprechblase)
	sprechblase.position = Text[line]["pos"]
	label = sprechblase.find_child("RichTextLabel")
	label.text = text_in
	label.custom_minimum_size.x = Text[line]["min_w_h"][0]
	label.custom_minimum_size.y = Text[line]["min_w_h"][1]
	var vport:SubViewport = label.find_parent("SubViewport")
	vport.size.x = label.custom_minimum_size.x
	vport.size.y = label.custom_minimum_size.y

func close_dialogue(line:String):
	var parent = Text[line]["Parent"]
	var par = curr_scene.find_child(parent)
	for child in par.get_children():
		if child.name == "SPRECHBLASE":
			child.queue_free()

