extends Spell

var speed
var dmg
var dmg_tick
var area
var sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 3000
	dmg = 10
	time = 0
	dmg_tick = 0.4
	area = get_node("Area2D")
	sprite = get_node("Sprite")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# search for first target in front of caster
	seek(delta)
	
	# deal damage every tick
	if fmod(time, dmg_tick) <= delta and target:
		damage(target, dmg)
		#shitty stun function
		target.position.x += 15
		
	# flip sprite for animation
	if fmod(time, 0.15) <= delta:
		flip_sprite_v()
	# kill node when key released
	if Input.is_action_just_released("key_2"):
		queue_free()


func seek(delta):
	# if collided, reset position of area2D to 0
	if collisions > 0:
		area.position.x = 0
		collisions -= 1
	# move area along sprite length to find collision
	var motion = Vector2(speed, 0)
	area.position = area.position + (motion * delta)
	# reset position and reset target if it reaches end of full sprite
	if area.position.x > sprite.texture.get_size().x * sprite.scale.x:
		area.position.x = 0
		target = null
	# set sprite region to location of colliding object, else set to low val
	if target:
		sprite.region_rect.size.x = (target.position.x - self.position.x) / sprite.scale.x
	else:
		sprite.region_rect.size.x = 35
