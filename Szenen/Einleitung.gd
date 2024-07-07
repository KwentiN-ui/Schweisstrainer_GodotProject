extends Node3D

signal fertig()
signal tutorial_fertig()

var Controller_L: XRController3D
var Controller_R: XRController3D
var Schweißgeraet: Schweissmaschine
var time = 0

var eingeblendet: bool = false
var helm: Node3D
@export var level = 0 # 0: Einleitung, 1: Grip, 2: Trigger, 3: Drehen, 4: Teleportieren 

var helm_auf: bool = false
var griffstueck_aufgenommen: bool = false
var aufnehmbarer_helm: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	aufnehmbarer_helm = find_parent("Main").find_child("Helm_aufnehmen")
	helm = find_parent("Main").find_child("Helm")
	helm.einleitung_ueberspringen.connect(_on_einleitung_ueberspringen)
	helm.helm_aufgenommen.connect(_on_helm_aufgenommen)
	Controller_L = find_parent("Main").find_child("LinkerController")
	Controller_R = find_parent("Main").find_child("RechterController")
	Schweißgeraet = find_parent("Main").find_child("Schweissgeraet")
	Schweißgeraet.picked.connect(_on_griffstueck_picked_up)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	match level:
		0:
			if !eingeblendet:
				TextManagerSprechblasen.add_dialogue("Einleitung")
				eingeblendet = true
			elif time >= 15:
				TextManagerSprechblasen.close_dialogue("Einleitung")
				eingeblendet = false
				level = 1
		1:
			if !eingeblendet:
				TextManagerSprechblasen.add_dialogue("Grip")
				eingeblendet = true
			if eingeblendet && (Controller_L.is_button_pressed("grip") || Controller_R.is_button_pressed("grip")):
				TextManagerSprechblasen.close_dialogue("Grip")
				eingeblendet = false
				level = 2
		2:
			if !eingeblendet:
				TextManagerSprechblasen.add_dialogue("Trigger")
				eingeblendet = true
			if eingeblendet && (Controller_L.is_button_pressed("trigger") || Controller_R.is_button_pressed("trigger")):
				TextManagerSprechblasen.close_dialogue("Trigger")
				eingeblendet = false
				level = 3
		3:
			if !eingeblendet:
				TextManagerSprechblasen.add_dialogue("Drehen")
				eingeblendet = true
			if eingeblendet && Controller_R.get_vector2("primary").x != 0:
				TextManagerSprechblasen.close_dialogue("Trigger")
				eingeblendet = false
				level = 4
		4:
			if !eingeblendet:
				TextManagerSprechblasen.add_dialogue("Teleportieren")
				eingeblendet = true
			if eingeblendet && Controller_R.get_input("ax_button"):
				TextManagerSprechblasen.close_dialogue("Teleportieren")
				eingeblendet = false
				level = 5
		5:
			if !eingeblendet:
				TextManagerSprechblasen.add_dialogue("Helm Position")
				TextManagerSprechblasen.add_dialogue("Helm aufsetzen")
				eingeblendet = true
			if eingeblendet && helm_auf:
				TextManagerSprechblasen.close_dialogue("Helm Position")
				TextManagerSprechblasen.close_dialogue("Helm aufsetzen")
				eingeblendet = false
				level = 6
		6:
			var helm_war_unten: bool	
			if !eingeblendet:
				TextManagerSprechblasen.add_dialogue("Helm benutzen")
				eingeblendet = true
			if eingeblendet && helm.helm_unten:
				TextManagerSprechblasen.close_dialogue("Helm benutzen")
				eingeblendet = false
				level = 7
		7:
			if !eingeblendet:
				TextManagerSprechblasen.add_dialogue("Schweissmaschine einschalten")
				TextManagerSprechblasen.add_dialogue("Schweissmaschine Position")
				eingeblendet = true
			if eingeblendet && Schweisslogik.strom_ein:
				TextManagerSprechblasen.close_dialogue("Schweissmaschine einschalten")
				TextManagerSprechblasen.close_dialogue("Schweissmaschine Position")
				eingeblendet = false
				level = 8
		8:
			if !eingeblendet:
				TextManagerSprechblasen.add_dialogue("Schweissstrom aendern")
				eingeblendet = true
			if eingeblendet && (Schweisslogik.strom != 100):
				TextManagerSprechblasen.close_dialogue("Schweissstrom aendern")
				eingeblendet = false
				level = 9
		9:
			if !eingeblendet:
				TextManagerSprechblasen.add_dialogue("Griffstueck nehmen")
				eingeblendet = true
			if eingeblendet && griffstueck_aufgenommen:
				TextManagerSprechblasen.close_dialogue("Griffstueck nehmen")
				eingeblendet = false
				level = 10
		10:
			if !eingeblendet:
				TextManagerSprechblasen.add_dialogue("Elektrode nehmen")
				eingeblendet = true
			if eingeblendet && Schweisslogik.elektrode_d != 0:
				TextManagerSprechblasen.close_dialogue("Elektrode nehmen")
				eingeblendet = false
				level = 11
		11:
			if !eingeblendet:
				TextManagerSprechblasen.add_dialogue("Schweissen erklären")
				eingeblendet = true
			if eingeblendet && Schweisslogik.gezuendet:
				TextManagerSprechblasen.close_dialogue("Schweissen erklären")
				eingeblendet = false
				level = 12
			fertig.emit() # Schweißblech wird eingeblendet
		12:
			pass
			tutorial_fertig.emit() # Aufseher kann sich dann bewegen
		20:
			TextManagerSprechblasen.close_dialogue("Teleportieren")
			TextManagerSprechblasen.close_dialogue("Drehen")
			TextManagerSprechblasen.close_dialogue("Grip")
			TextManagerSprechblasen.close_dialogue("Trigger")
			TextManagerSprechblasen.close_dialogue("Einleitung")
			fertig.emit()
			tutorial_fertig.emit() # Aufseher kann sich dann bewegen
		_:
			pass

func _on_einleitung_ueberspringen():
	level = 20
	eingeblendet = false

func _on_helm_aufgenommen():
	helm_auf = true

func _on_griffstueck_picked_up():
	griffstueck_aufgenommen = true
