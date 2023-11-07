extends RigidBody2D

@export var speed = 130
@export var curve = 0.1 # Alter direction

var goal = 0
var step_counts = [1000000,1000000]
var direction = Vector2(0,1)
var rd = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	direction = Vector2(rd.randf_range(-1,1), rd.randf_range(-1,1))
	direction = direction.normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var coll = self.move_and_collide(direction * delta * speed)
	
	if step_counts[0] < 1000000 :
		step_counts[0] = step_counts[0] + 1
	if step_counts[1] < 1000000 :
		step_counts[1] = step_counts[1] + 1
		
	if coll:
		var coll_name = coll.get_collider().name
		if(coll_name == "Goal_A"):
			step_counts[0] = 0
			goal = 1
			direction = -direction
		elif(coll_name == "Goal_B"):
			step_counts[1] = 0
			goal = 0
			direction = -direction
		else:
			direction = direction.bounce(coll.get_normal())
	
func shout_at(node : RigidBody2D, steps : Array, range : float):
	var chase = false
	#print("self %d other %d, eval %d" % [step_counts[0],steps[0],0])
	if steps[0] < step_counts[0]:
		step_counts[0] = steps[0]
		if goal == 0:
			chase = true
	
	elif steps[1] < step_counts[1]:
		step_counts[1] = steps[1]
		if goal == 1:
			chase = true
			
	if chase:
		direction = self.position.direction_to(node.position) + direction
		direction = direction.normalized()
		

func _on_step_timer_timeout():
	direction = Vector2(direction.x + rd.randfn(0,curve), direction.y + rd.randfn(0,curve))
	direction = direction.normalized()
