extends Control

var weld_os:Control

func _ready():
	weld_os = find_parent("WeldOS")
	assert(weld_os!=null,"WeldOS konnte nicht gefunden werden! Wurde die Root Szene ausgeführt?")

func _on_erste_schweißnaht_pressed():
	Schweisslogik.level = load("res://Level/level_1.tscn").instantiate()

func _on_grosses_blech_pressed():
	Schweisslogik.level = load("res://Level/level_2.tscn").instantiate()

func _on_beenden_pressed():
	get_tree().quit()

func _on_einführung_pressed():
	pass # Replace with function body.
