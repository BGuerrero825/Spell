extends Node2D

var deltax
var deltay
var speed := 1.5

func init(origin, target):
	$target.position = target - origin
	
# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = 1
	$fireball.position = $origin.position
	deltax = abs($target.position.x - $origin.position.x)
	deltay = abs($target.position.y - $origin.position.y)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$fireball.scale -= Vector2(0.01, 0.01)
	$fireball.position.x = move_toward($fireball.position.x, $target.position.x, deltax * speed * delta)
	$fireball.position.y = move_toward($fireball.position.y, $target.position.y, deltay * speed * delta)
	if $fireball.position == $target.position:
		queue_free()
