extends Spell

var sprite
var tick_dmg
var tick

# Called when the node enters the scene tree for the first time.
func _ready():
	tick_dmg = 10
	tick = 0.4
	sprite = get_node("Sprite")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# flip sprite for animation
	if fmod(time, 0.2) <= delta:
		sprite.flip_h = !sprite.flip_h
	# apply damage to enemies in fire every .4 seconds
	if fmod(time, tick) <= delta:
		for overlap in self.get_node("Area2D").get_overlapping_areas():
			var collider = overlap.get_parent()
			if hostile(collider):
				damage(collider, tick_dmg)
	# descale occasionally
	if fmod(time, 1.5) <= delta:
			self.scale *= 0.9
	# destroy sprite if scale becomes too small
	if self.scale.x < 0.5:
		queue_free()
