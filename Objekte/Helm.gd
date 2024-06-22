extends Node3D
@export var beschleunigungstrigger = 200 # °/s
var unten:bool = false

var sichtbar:bool = false

var aufnehmbarer_helm:Node3D

var Contr_rechts:XRController3D
var Contr_links:XRController3D

var v_alt:Vector3 = Vector3(0,0,0)
var helm_unten:bool = false 
var sekunden_seit_helm:float = 0 # sekunden seit helm animation
var helm_lange_in_position:bool = true #helm min 1 sekunde in position

var time = 0

@export var entfernung_helm_helm = 0.2

func _ready():
	aufnehmbarer_helm = $/root/Main/Helm_aufnehmen/XRToolsPickable/Helm
	if !is_instance_valid(aufnehmbarer_helm):
		aufnehmbarer_helm = $/root/Main_XR_sim/Main/Helm_aufnehmen/XRToolsPickable/Helm
	Contr_rechts = $"../../RechterController"
	Contr_links = $"../../LinkerController"
	if unten:
		helm_runter(-1)
	else:
		helm_hoch(1.0)
	TextManagerSprechblasen.add_dialogue("Aufseher","Bitte Helm aufsetzen",Vector3(-1,1.4,0),100,50)
	TextManagerSprechblasen.add_dialogue("Helm_aufnehmen","HELM",Vector3(0,0.4,0),80,20)

func _physics_process(delta) -> void:
	time+=delta
	if sichtbar:
		visible = true
	else:
		visible = false 
	helm_bewegung(delta)
	if is_instance_valid(aufnehmbarer_helm):
		helm_aufnehmen()
	else:
		if time >= 5:
			AufseherEmotion.fertig()
	
	
func helm_aufnehmen():
	var helm_anderer_helm = (aufnehmbarer_helm.global_position-global_position) #Vektor Helm <-> rechter Controller
	# .length ermittelt die Länge des Vektors, keine extra Varialbe notwendig
	if helm_anderer_helm.length() <= entfernung_helm_helm:
		sichtbar = true
		TextManagerSprechblasen.close_dialogue("Helm_aufnehmen")
		aufnehmbarer_helm.queue_free()
		TextManagerSprechblasen.close_dialogue("Aufseher")
		time = 0
		AufseherEmotion.freuen()
		

func helm_bewegung(delta):
	var helm_contr_rechts = (Contr_rechts.global_position-global_position) #Vektor Helm <-> rechter Controller
	
	var helm_contr_links = (Contr_links.global_position-global_position) # Vektor Helm <-> linker Controller

	var v_neu = global_rotation_degrees  # Rotationsvektor des Helms
	var dv = v_neu.z - v_alt.z  # Änderung im dritten Eintrag
	var aenderung = dv / delta  # Änderungsrate pro Sekunde
	v_alt = v_neu  

	# verhindert, dass helm animation bei sofortiger gegenbewegung 
	# wieder zurück geht
	if (!helm_lange_in_position && sekunden_seit_helm <= 1):
		sekunden_seit_helm += delta
	elif (!helm_lange_in_position && sekunden_seit_helm >= 1):
		helm_lange_in_position = true
	
	#wenn rechter controller an helm, rechter controller "grip"
	if (helm_contr_rechts.length() <= 0.2  && helm_lange_in_position && Contr_rechts.get_input("trigger") && sichtbar):
		if helm_unten:
			helm_hoch(1)
			helm_unten = false
		elif !helm_unten:
			helm_runter(-1)
			helm_unten = true
		helm_lange_in_position = false
		sekunden_seit_helm = 0
	
	#wenn linker controller an helm, linker controller "grip"
	if (helm_contr_links.length() <= 0.2  && helm_lange_in_position && Contr_links.get_input("trigger") && sichtbar):
		if helm_unten:
			helm_hoch(1)
			helm_unten = false
		elif !helm_unten:
			helm_runter(-1)
			helm_unten = true
		helm_lange_in_position = false
		sekunden_seit_helm = 0
		
	# wenn winkelgeschwindigkeit helm größer als beschleunigungstrigger
	if (aenderung < -beschleunigungstrigger && !helm_unten && helm_lange_in_position && sichtbar): # beschleunigung nach unten > beschleunigungstrigger
		helm_runter(aenderung/80)
		helm_unten = true
		sekunden_seit_helm = 0
		helm_lange_in_position = false

func helm_hoch(geschwindigkeit):
	# Spielt Animation ab
	$AnimationPlayer.play("Flip_up",-1,geschwindigkeit)
	
func helm_runter(geschwindigkeit):
	$AnimationPlayer.play("Flip_up",-1,geschwindigkeit,true)
