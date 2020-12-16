extends Node2D

var mana
const FIREBALL = preload("res://objects/Fireball.tscn")
const JOLT = preload("res://objects/Jolt.tscn")
const ICICLE = preload("res://objects/Icicle.tscn")
const ENEMY = preload("res://objects/Enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	mana = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("key_1"):
		var fireball = FIREBALL.instance()
		get_parent().add_child(fireball)
		fireball.position = self.position + Vector2(0, -15)
		mana -= 25
	elif Input.is_action_just_pressed("key_2"):
		var jolt = JOLT.instance()
		get_parent().add_child(jolt)
		jolt.position = self.position + Vector2(0, -15)
	elif Input.is_action_just_pressed("key_3"):
		var icicle = ICICLE.instance()
		get_parent().add_child(icicle)
		icicle.position = self.position + Vector2(0, -15)
		# debugging, adds enemy
	elif Input.is_action_just_pressed("key_5"):
		var enemy = ENEMY.instance()
		get_parent().add_child(enemy)
		enemy.position = self.position + Vector2(1500,0)
	
	get_parent().get_node("Bar/Mana").rect_size.x = mana * 5
	if mana < 100:
		mana += 0.1
