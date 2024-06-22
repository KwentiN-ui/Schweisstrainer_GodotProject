extends Node3D

@export var movement_speed: float = 0.8
@export var abstand_zum_spieler:float = 3.5
@onready var navigation_agent: NavigationAgent3D = get_node("NavigationAgent3D")
var movement_delta: float
var animation: AnimationPlayer
var spieler: Node3D
var alte_pos_spieler: Vector3

func _ready() -> void:
	spieler = find_parent("Main").find_child("XRCamera3D")
	alte_pos_spieler = spieler.global_position
	animation = find_child("AnimationPlayer")
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func abstand():
	return Vector3(-abstand_zum_spieler*sin(spieler.global_rotation.y),0,-abstand_zum_spieler *cos(spieler.global_rotation.y))

func _physics_process(delta):
	Navigation(delta)

func Navigation(delta):
	var ziel = spieler.global_position+abstand()
	print(spieler.global_position)
	if spieler.global_position.x >= 0.4 and spieler.global_position.z <= 5 and spieler.global_position.z >= -9.3:
		if ziel.x <= 0.4:
			ziel.x = 1
		if ziel.x >= 10:
			ziel.x = 10
		if ziel.z  >= 5.1:
			ziel.z = 5.1
		if ziel.z <= -9:
			ziel.z = -9
	var v_spieler_aufseher: Vector3 = spieler.global_position - global_position
	var abstand: float = sqrt(v_spieler_aufseher.x**2 + v_spieler_aufseher.y**2 + v_spieler_aufseher.z**2)
	var bewegung = sqrt((spieler.global_position.x-alte_pos_spieler.x)**2 + (spieler.global_position.y-alte_pos_spieler.y)**2 + (spieler.global_position.z-alte_pos_spieler.z)**2 )
	if bewegung > 1:
		set_movement_target(ziel)
	if navigation_agent.is_navigation_finished():
		look_at(spieler.global_position)
		rotation.x = 0
		rotation.z = 0
		animation.play("stehen")
		return

	position.y=0
	look_at(navigation_agent.get_next_path_position())
	rotation.x = 0
	rotation.z = 0

	animation.play("Gehen",-1,2.3)
	movement_delta = movement_speed * delta
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	var new_velocity: Vector3 = global_position.direction_to(next_path_position) * movement_delta
	if navigation_agent.avoidance_enabled:
		navigation_agent.velocity = new_velocity
	else:
		_on_velocity_computed(new_velocity)

func _on_velocity_computed(safe_velocity: Vector3) -> void:
	global_position = global_position.move_toward(global_position + safe_velocity, movement_delta)
func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	_on_velocity_computed(safe_velocity)
