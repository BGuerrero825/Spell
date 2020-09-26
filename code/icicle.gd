extends Spell

var speed
var hang_time

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 1000
	hang_time = 0.25
	coll_dmg = 25

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# if icicle collides with an object, destroy
	if collisions > 0:
		queue_free()
	# do nothing while icicle waits to launch
	if time < hang_time:
		pass
	else:
		# set motion and update icicle location
		var motion = Vector2(speed, 0)
		self.position = self.position + (motion * delta)
		# if distance between parent (caster) and projectile (icicle) gets too large, then self destruct
		if abs(self.position.x - get_parent().position.x) > 5000:
			queue_free()
		# flip sprite for animation
	if fmod(time, 0.15) <= delta:
		flip_sprite_v()
