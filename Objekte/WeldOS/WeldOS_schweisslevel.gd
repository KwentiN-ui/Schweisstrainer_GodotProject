extends Control

var weld_os:Control
var todo_daten:Node
var aufgabenliste:ItemList

func _ready():
	weld_os = find_parent("WeldOS")
	if weld_os==null:
		print("WeldOS konnte nicht gefunden werden! Wurde die Root Szene ausgeführt?")

	todo_daten = find_child("TODO")
	assert(todo_daten!=null,"Keine TODO Node gefunden!")
	aufgabenliste = find_child("Aufgaben")
	assert(aufgabenliste!=null,"Tab Aufgabe nicht gefunden!")
	fortschritt_aktualisieren()

func _on_abbruch_pressed():
	weld_os.aktuelle_szene = weld_os.menu_szene

func fortschritt_aktualisieren():
	for aufgabe in todo_daten.get_children():
		var neuer_index:int = aufgabenliste.add_item(aufgabe.name)
		aufgabenliste.set_item_disabled(neuer_index,not aufgabe.get_meta("fertig"))
