@tool
extends StaticBody3D

@onready var label_d:Label3D = $label_durchmesser
@onready var label_l:Label3D = $label_laenge

@export_category("Eigenschaften der Elektrode")
@export_range(1e-3,50e-3,1e-3) var durchmesser: float: #m
	set(neu):
		durchmesser = neu
		if is_instance_valid(label_d) and durchmesser is float:
			label_d.text = "d = "+str(int(durchmesser*1e3)) + " mm"
@export_range(5e-3,1) var länge: #m
	set(neu):
		länge = neu
		if is_instance_valid(label_l) and länge is float:
			label_l.text = "l = "+str(int(länge*1e3)) + " mm"

var hand_r: XRController3D
var hand_l: XRController3D
var r_pressed = false
var l_pressed = false

func _ready():
	hand_r = Schweisslogik.spieler["hand_r"]
	hand_l = Schweisslogik.spieler["hand_l"]
	hand_r.button_pressed.connect(hand_r_pressed)
	hand_l.button_pressed.connect(hand_l_pressed)
	hand_r.button_released.connect(hand_r_released)
	hand_l.button_released.connect(hand_l_released)
	
	durchmesser = durchmesser
	länge = länge

func _on_xr_tools_interactable_area_pointer_event(event):
	if r_pressed or l_pressed:
		Schweisslogik.elektrode_d = durchmesser
		Schweisslogik.elektrode_l = länge

func hand_r_pressed(button):
	if button == "trigger_click":
		r_pressed = true
func hand_l_pressed(button):
	if button == "trigger_click":
		l_pressed = true
func hand_r_released(button):
	if button == "trigger_click":
		r_pressed = false
func hand_l_released(button):
	if button == "trigger_click":
		l_pressed = false
