extends Node3D
@export var unten:bool:
	set(new_unten):
		unten = new_unten
		if new_unten==true:
			helm_runter(-1)
		elif new_unten==false:
			helm_hoch(1.0)

var v_alt:Vector3 = Vector3(0,0,0)
var helm_unten:bool = false 
var sekunden_seit_helm:float = 0 # sekunden seit helm animation
var helm_lange_in_position:bool = true

func _ready():
	if unten:
		helm_runter(-1)
	else:
		helm_hoch(1.0)

func _physics_process(delta):
	var v_neu = global_rotation_degrees 
	var dv = v_neu.z - v_alt.z  # Änderung im dritten Eintrag
	var aenderung = dv / delta  # Änderungsrate pro Sekunde
	v_alt = v_neu  
	
	# verhindert, dass helm animation bei sofortiger gegenbewegung 
	# wieder zurück geht
	if (!helm_lange_in_position && sekunden_seit_helm <= 1):
		sekunden_seit_helm += delta
	elif (!helm_lange_in_position && sekunden_seit_helm >= 1):
		helm_lange_in_position = true
		
	if (aenderung < -150 && !helm_unten && helm_lange_in_position): # beschleunigung nach oben > 150°/s
		helm_runter(aenderung/80)
		helm_unten = true
		sekunden_seit_helm = 0
		helm_lange_in_position = false
		
	if (aenderung > 150 && helm_unten && helm_lange_in_position): # beschleunigung nach unten > 150°/s
		helm_hoch(aenderung/80)
		helm_unten = false
		sekunden_seit_helm = 0
		helm_lange_in_position = false


func helm_hoch(geschwindigkeit):
	# Spielt Animation ab
	$AnimationPlayer.play("Flip_up",-1,geschwindigkeit)
func helm_runter(geschwindigkeit):
	$AnimationPlayer.play("Flip_up",-1,geschwindigkeit,true)
