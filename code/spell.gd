extends Node2D

class_name Spell

var time = 0
var coll_dmg = 1
var collisions = 0
var target = null
var grounded = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta

func flip_sprite_v():
	if(get_node("Sprite")):
		get_node("Sprite").flip_v = !get_node("Sprite").flip_v
	else:
		print("No child node found with name 'Sprite'")
	
func flip_sprite_h():
	if(get_node("Sprite")):
		get_node("Sprite").flip_h = !get_node("Sprite").flip_h
	else:
		print("No child node found with name 'Sprite'")

#returns whether or not target is an enemy
func hostile(collider):
	if collider.get("hostile"):
		return true
		
# damage given target by dmg amount if hp value exists
func damage(target, dmg):
	if target.get("hp"):
		target.hp -= dmg
	else:
		print(target.name + " has no hp property.")

# called on collision
func _on_Area2D_area_entered(area):
	var collider = area.get_parent()
	# if colliding body is hostile, do damage
	if hostile(collider):
		target = collider
		damage(target, coll_dmg)
		collisions += 1
	# if colliding with the ground
	elif (collider.name == "Ground" or collider.name == "ground"):
		grounded += 1
