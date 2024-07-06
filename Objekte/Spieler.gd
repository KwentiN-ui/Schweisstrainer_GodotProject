extends Node3D

func _ready():
	Schweisslogik.spieler["root"] = self
	Schweisslogik.spieler["hand_r"] = $XROrigin3D/RechterController
	Schweisslogik.spieler["hand_l"] = $XROrigin3D/LinkerController
