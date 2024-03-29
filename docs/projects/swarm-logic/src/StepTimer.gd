extends Timer

@export var shout_dist = 110

var agents

var shout_distance_squared = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	shout_distance_squared = shout_dist * shout_dist
	agents = get_tree().get_nodes_in_group("Agents")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timeout():
	for a in agents:
		for b in agents:
			if (a != b and 
				a.position.distance_squared_to(b.position) <= shout_distance_squared):
					b.shout_at(a,a.step_counts,shout_dist)
					

func _on_spawn_timer_spawn():
	agents = get_tree().get_nodes_in_group("Agents")

