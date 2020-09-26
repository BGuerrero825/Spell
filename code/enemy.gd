extends Node2D

export var hp = 100
var hostile = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if hp <= 0:
		queue_free()

func _physics_process(_delta):
	self.position.x -= 1
