extends Node


var Text: Dictionary = {
		"Einleitung" : 
			{
			"Inhalt": 
				"[font_size={30}]Willkommen![/font_size]
In dieser virtuellen Werkstatt kann das  Schweißverfahren Lichtbogenhandschweißen erlernt oder geübt werden.
[color=#CDFFE5]Um OHNE eine Einweisung zu beginnen einfach den Helm aufsetzen und losschweißen.[/color]",
			"Parent" : "Aufseher",
			"pos" : Vector3(-2.2,0.5,0),
			"min_w_h" : [300,340], # min width, heigth
			"bg" : false
			},
		"Teleportieren" : 
			{
			"Inhalt" :
				"[p]Zum  Bewegen den \"A\"-Knopf am rechten Controller drücken und auf den Zielort zeigen.[/p]
				[p][img=270]res://Bilder/fuer_Text/A_Knopf.png[/img][/p]
				[p][color=#CDFFE5]Zum Fortfahren teleportieren![/color][/p]",
			"Parent" : "Aufseher",
			"pos" : Vector3(-2.2,1,0),
			"min_w_h" : [300,430],
			"bg" : false
			},
		"Drehen" : 
			{
			"Inhalt" : 
				"[p]Siehe dich mit dem Joystick des rechten Controllers um!.[/p]
				[p][img=300]res://Bilder/fuer_Text/Joystick.png[/img][/p]
				[p][color=#CDFFE5]Zum Fortfahren drehen![/color][/p]",
			"Parent" : "Aufseher",
			"pos" : Vector3(-2.2,1,0),
			"min_w_h" : [300,430],
			"bg" : false
			},
		"Grip" : 
			{
			"Inhalt" : 
				"[p]Zum Greifen von Objekten \"Grip-Button\" drücken.[/p]
				[p][img=250]res://Bilder/fuer_Text/Grip.png[/img][/p]
				[p][color=#CDFFE5]Zum Fortfahren \"Grip-Button\" drücken![/color][/p]",
			"Parent" : "Aufseher",
			"pos" : Vector3(-2.2,1,0),
			"min_w_h" : [280,410],
			"bg" : false
			},
		"Trigger" : 
			{
			"Inhalt" : 
				"[p]Verwende den \"Trigger-Button\" um mit Dingen zu interagieren (Knöpfe, Displays, Gegenstände).[/p]
				[p][img=100]res://Bilder/fuer_Text/Trigger.png[/img][/p]
				[p][color=#CDFFE5]Zum Fortfahren \"Trigger-Button\" drücken![/color][/p]",
			"Parent" : "Aufseher",
			"pos" : Vector3(-2.2,1,0),
			"min_w_h" : [300,430],
			"bg" : false
			},
		"Helm aufsetzen" : 
			{
			"Inhalt" : 
				"[p]Damit du dir nicht die Augen verbrennst solltest du einen Schweißhelm tragen. Greife ihn, und führe den Helm zu deinem Kopf um ihn aufzusetzen![/p]",
			"Parent" : "Aufseher",
			"pos" : Vector3(-2.0,0.8,0),
			"min_w_h" : [300,220],
			"bg" : false
			},
		"Helm Position" : 
			{
			"Inhalt" : 
				"[pulse][p align=center][color=red]Schweißhelm[/color][/p]
				[p align=center][font_size=40]\u2193[/font_size][/p]",
			"Parent" : "Helm_aufnehmen",
			"pos" : Vector3(0,0.2,0),
			"min_w_h" : [200,200],
			"bg" : true
			},
		"Helm benutzen" : 
			{
				"Inhalt" :
					"[p]Um das Visier herunterzuklappen entweder mit dem Kopf kräftig nicken oder eine Hand nah an den Kopf halten und \"Trigger\" drücken.[/p]
					[p]Zum Hochklappen ebenfalls die Hand nah an den Kopf halten und Trigger drücken.[/p]
					[p][color=#CDFFE5]Zum Fortfahren den Helm herunterklappen![/color][/p]",
				"Parent" : "Aufseher",
				"pos" : Vector3(-2.2,0.8,0),
				"min_w_h" : [300,480],
				"bg" : false
			},
		"Schweissmaschine Position" : 
			{
			"Inhalt" : 
				"[pulse][p align=center][color=red]Schweißmaschine[/color][/p]
				[p align=center][font_size=40]\u2193[/font_size][/p]",
			"Parent" : "Schweissgeraet",
			"pos" : Vector3(0,1.4,0),
			"min_w_h" : [200,200],
			"bg" : true
			},
		"Schweissmaschine einschalten":
			{
				"Inhalt" : 
					"[p]Zum Schweißen wird eine Schweißmaschine benötigt.[/p]
					[p]Um den Strom einzuschalten gibt es in der oberen, rechten Ecke der Maschine einen Schalter. Betätige ihn mit \"Trigger\" wenn der rote Laser auf ihn zeigt.
					[p][color=#CDFFE5]Zum Fortfahren die Schweißmaschine einschalten![/color][/p]",
				"Parent" : "Aufseher",
				"pos" : Vector3(-2.5,0.8,0),
				"min_w_h" : [320,480],
				"bg" : false
			},
		"Schweissstrom aendern":
			{
				"Inhalt" : 
					"[p] Um der Naht mehr Wärme zuzuführen kann man den Schweißstrom erhöhen.[/p]
					[p]Hierzu dient der Slider neben dem Display. Beachte, dass mit steigender Stromstärke deine Elektrode schneller abbrennt.
					[p][color=#CDFFE5]Zum Fortfahren die Schweißstromstärke ändern![/color][/p]",
				"Parent" : "Aufseher",
				"pos" : Vector3(-2.5,0.5,0),
				"min_w_h" : [400,460],
				"bg" : false
			},
		"Griffstueck nehmen" : 
			{
				"Inhalt" : 
					"[p]Auf der Schweißmaschine liegt das Griffstück in welches die Elektrode zum Schweißen eingespannt wird.[/p]
					[p][color=#CDFFE5]Zum Fortfahren das Griffstück greifen![/color][/p]",
				"Parent" : "Aufseher",
				"pos" : Vector3(-2.5,0.5,0),
				"min_w_h" : [300,240],
				"bg" : false
			},
		"Elektrode nehmen" : 
			{
				"Inhalt" : 
					"[p]Zum Schweißen wird eine Stabelektrode benötigt. Diese befinden sich in den Kartons auf dem Schweißtisch.[/p]
					[p]Zum in das Griffstück einzuspannen mit dem Controller der das Griffstück hält auf den jeweiligen Karton zeigen und sobald ein roter Laser erscheint mit \"Trigger\" eine neue Elektrode einspannen.[/p]
					[p][color=#CDFFE5]Zum Fortfahren eine neue Elektrode einspannen![/color][/p]",
				"Parent" : "Aufseher",
				"pos" : Vector3(-2.0,0.8,0),
				"min_w_h" : [300,510],
				"bg" : false
			},
		"Schweissen erklären" : 
			{
				"Inhalt" : 
					"[p] Zum Schweißen die Elektrode an das zu schweißende Blech halten und auf den Abstand achten. Falls der Abstand zu groß wird, geht der Lichtbogen aus und die Elektrode muss neu gezündet werden. [/p]
					[p]Und niemals vor dem Schweißen vergessen den Schweißhelm herunterzuklappen![/p]",
				"Parent" : "Aufseher",
				"pos" : Vector3(-2.2,0.8,0),
				"min_w_h" : [300,410],
				"bg" : false
			},
		"Schweisselektroden Position" : 
			{
			"Inhalt" : 
				"[pulse][p align=center][color=red]Stabelektroden[/color][/p]
				[p align=center][font_size=40]\u2193[/font_size][/p]",
			"Parent" : "ErsatzelektrodeSchachtel1",
			"pos" : Vector3(0,0.3,0),
			"min_w_h" : [200,200],
			"bg" : true
			},
		}

var Zeit_Einleitung = 15 #Sekunden

var Sprechblasen_Scene: PackedScene
var sprechblase: Node3D
var curr_scene = null
var label: RichTextLabel

var ControllerL: XRController3D
var ControllerR: XRController3D

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().root
	curr_scene = root.get_child(root.get_child_count()-1)
	Sprechblasen_Scene = preload("res://Objekte/Sprechblasen.tscn")
	ControllerL = curr_scene.find_child("LinkerController")
	ControllerR = curr_scene.find_child("RechterController")
	


func add_dialogue(line:String):
	var text_in = Text[line]["Inhalt"]
	sprechblase = Sprechblasen_Scene.instantiate()
	curr_scene.find_child(Text[line]["Parent"]).add_child(sprechblase)
	sprechblase.position = Text[line]["pos"]
	sprechblase.find_child("SubViewport").transparent_bg = Text[line]["bg"]
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

