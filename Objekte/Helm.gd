extends Node3D
@export var unten:bool:
	set(new_unten):
		unten = new_unten
		if new_unten==true:
			helm_runter(-1)
		elif new_unten==false:
			helm_hoch(1.0)


var Contr_rechts:XRController3D
var Contr_links:XRController3D

var v_alt:Vector3 = Vector3(0,0,0)
var helm_unten:bool = false 
var sekunden_seit_helm:float = 0 # sekunden seit helm animation
var helm_lange_in_position:bool = true #helm min 1 sekunde in position

func _ready():#
	Contr_rechts = $"../../RechterController"
	Contr_links = $"../../LinkerController"
	if unten:
		helm_runter(-1)
	else:
		helm_hoch(1.0)

func _physics_process(delta):
	var helm_contr_rechts = (Contr_rechts.global_position-global_position) #Vektor Helm <-> rechter Controller
	var dist_helm_contr_rechts = sqrt(helm_contr_rechts.x**2+helm_contr_rechts.y**2+helm_contr_rechts.z**2) # Abstand
	
	var helm_contr_links = (Contr_links.global_position-global_position) # Vektor Helm <-> linker Controller
	var dist_helm_contr_links = sqrt(helm_contr_links.x**2+helm_contr_links.y**2+helm_contr_links.z**2) # Abstand

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
	if (dist_helm_contr_rechts <= 0.2  && helm_lange_in_position && Contr_rechts.get_input("grip")):
		if helm_unten:
			helm_hoch(1)
			helm_unten = false
		elif !helm_unten:
			helm_runter(-1)
			helm_unten = true
		helm_lange_in_position = false
		sekunden_seit_helm = 0
	
	#wenn linker controller an helm, linker controller "grip"
	if (dist_helm_contr_links <= 0.2  && helm_lange_in_position && Contr_links.get_input("grip")):
		if helm_unten:
			helm_hoch(1)
			helm_unten = false
		elif !helm_unten:
			helm_runter(-1)
			helm_unten = true
		helm_lange_in_position = false
		sekunden_seit_helm = 0
		
	# wenn winkelgeschwindigkeit helm größer als 150°/s
	if (aenderung < -150 && !helm_unten && helm_lange_in_position): # beschleunigung nach unten > 150°/s
		helm_runter(aenderung/80)
		helm_unten = true
		sekunden_seit_helm = 0
		helm_lange_in_position = false

func helm_hoch(geschwindigkeit):
	# Spielt Animation ab
	$AnimationPlayer.play("Flip_up",-1,geschwindigkeit)
func helm_runter(geschwindigkeit):
	$AnimationPlayer.play("Flip_up",-1,geschwindigkeit,true)
