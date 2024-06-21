extends Node3D

@export var movement_speed: float = 0.8
@onready var navigation_agent: NavigationAgent3D = get_node("NavigationAgent3D")
var movement_delta: float
var animation: AnimationPlayer
var spieler: Node3D

func _ready() -> void:
	spieler = find_parent("Main").find_child("Helm")
	animation = find_child("AnimationPlayer")
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func _physics_process(delta):
	var v_spieler_aufseher: Vector3 = spieler.global_position - global_position
	var abstand: float = sqrt(v_spieler_aufseher.x**2 + v_spieler_aufseher.y**2 + v_spieler_aufseher.z**2)
	if abstand >= 1:
		set_movement_target(spieler.global_position)
	if navigation_agent.is_navigation_finished():
		animation.play("stehen")
		return

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
