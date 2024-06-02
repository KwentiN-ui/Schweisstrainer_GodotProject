extends Node3D
@export var unten:bool:
	set(new_unten):
		unten = new_unten
		if new_unten==true:
			helm_runter()
		elif new_unten==false:
			helm_hoch()

func _ready():
	if unten:
		helm_runter()
	else:
		helm_hoch()

func _input(_event):
	if Input.is_action_pressed("ui_up"):
		unten = false
	if Input.is_action_pressed("ui_down"):
		unten = true

func helm_hoch():
	# Spielt Animation ab
	$AnimationPlayer.play("Flip_up")
func helm_runter():
	$AnimationPlayer.play_backwards("Flip_up")
