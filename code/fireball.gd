extends Spell

var speed
var traj
var traveled
var motion
var released
var key = "key_1"
const G = 500
const FIREPIT = preload("res://objects/Pit.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 600
	coll_dmg = 50
	traj = -150
	traveled = Vector2(0,0)
	motion = Vector2(0,0)
	released = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	check_collision()
	# fireball charge-up
	if Input.is_action_pressed(key) and !released:
		traj -= G * 0.5 * delta
		self.position.y -= 2
	# fireball in air
	else:
		released = true
		motion = Vector2(speed, traj)
		traj += G * delta
		self.position = self.position + (motion * delta)
		traveled += motion * delta
		# if distance between parent (root) and projectile (fireball) gets too large, then self destruct
		if abs(traveled.x) > 5000 or abs(traveled.y) > 5000:
			queue_free()
	# flip sprite for animation
	if fmod(time, 0.10) <= delta:
		get_node("Sprite").flip_v = !get_node("Sprite").flip_v

func check_collision():
	# if fireball has collided, destroy self
	if collisions > 0:
		queue_free()
	# if fireball has hit ground, create fire pit and destroy self
	if grounded > 0:
		var firepit = FIREPIT.instance()
		get_parent().add_child(firepit)
		firepit.position = self.position
		queue_free()
