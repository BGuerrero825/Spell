extends Node2D

var spell_power
const ICICLE = preload("res://objects/Icicle.tscn")
const FIREBALL = preload("res://objects/Fireball.tscn")
const ENEMY = preload("res://objects/Enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	spell_power = 25
	get_parent().get_node("Tome").connect("spell_typed", self,"on_Tome_spell_typed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	get_parent().get_node("Bar/SpellPower").rect_size.x = spell_power
	#stabilize spell power around 35%
	var decay_rate = (spell_power - 35) * 0.001
	spell_power -= decay_rate
	if spell_power < 0:
		spell_power = 0
	if spell_power > 100:
		spell_power = 100
		
func on_Tome_spell_typed(spell):
	if spell == "icicle":
		var icicle = ICICLE.instance()
		get_parent().add_child(icicle)
		icicle.position = self.position + Vector2(0, -15)
		spell_power -= 5
	if spell == "fireball":
		var fireball = FIREBALL.instance()
		fireball.init($hand_pos.get_global_transform().get_origin(), get_parent().get_node("Enemy").get_global_transform().get_origin())
		get_parent().add_child(fireball)
		fireball.position = $hand_pos.get_global_transform().get_origin()
		spell_power -= 10
