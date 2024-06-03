extends Control

var weld_os:Control

func _ready():
	weld_os = find_parent("WeldOS")
	assert(weld_os!=null,"WeldOS konnte nicht gefunden werden! Wurde die Root Szene ausgeführt?")

func _on_erste_schweißnaht_pressed():
	weld_os.aktuelle_szene = weld_os.schweiss_szene


func _on_beenden_pressed():
	get_tree().quit()
