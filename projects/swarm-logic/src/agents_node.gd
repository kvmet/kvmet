extends Node2D

@export var agents_per_frame = 1
@export var shout_dist = 500

var agent_num = 0
var agents
var shout_distance_squared = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	shout_distance_squared = shout_dist * shout_dist
	agents = get_tree().get_nodes_in_group("Agents")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var start = agent_num
	var end = min(agent_num + agents_per_frame, agents.size() - 1)
	if end >= agents.size():
		agent_num = 0
	else:
		agent_num = end
	
	for a in range(start,end):
		for b in agents:
			if (agents[a] != b and 
				agents[a].position.distance_squared_to(b.position) <= shout_distance_squared):
					b.shout_at(agents[a],agents[a].step_counts,shout_dist)

func _on_spawn_timer_spawn():
	agents = get_tree().get_nodes_in_group("Agents")
