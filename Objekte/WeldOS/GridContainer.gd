extends GridContainer

var buttons: Array[Node]

var MAX_V = 550
var MAX_H = 1150

# Called when the node enters the scene tree for the first time.
func _ready():
	buttons = get_children()
	for button in buttons:
		button.size = Vector2(150,150)
		print(button,":",button.size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
