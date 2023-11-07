extends Timer

@export var agent_scene : PackedScene
@export var spawn_point : Marker2D

var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timeout():
	var ag = agent_scene.instantiate()
	ag.position = spawn_point.position
	ag.speed = randf_range(150,150)
	ag.curve = randf_range(0.02,0.03)
	
	self.add_sibling(ag)
	
	count += 1
	
	if count > 400:
		self.stop()
	
	pass # Replace with function body.
