extends Node3D

@export var knopfmesh:MeshInstance3D

signal knopf_pressed
var btn_pressed := false:
	set(new_pressed):
		btn_pressed =  new_pressed
		update_visuals()
		if new_pressed:
			knopf_pressed.emit()

var controller:XRController3D


func update_visuals():
	if btn_pressed:
		knopfmesh.position.y = 0.004
	else:
		knopfmesh.position.y = 0.017




func _on_area_3d_area_entered(area:Area3D):
	btn_pressed = true
	controller = area.get_parent()

func _on_area_3d_area_exited(_area:Area3D):
	btn_pressed = false
	controller = null
