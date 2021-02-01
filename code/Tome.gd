extends Node

var file = File.new()
var word_array := []
var active_words := []
var spell_list := ["fireball", "icicle", "jolt"]

func _ready():
	file.open("res://word_list.txt", file.READ)
	while not file.eof_reached():
		word_array.append(file.get_line())
	randomize()
	generate_list()
	update_text()
	
func generate_list():
	for i in range(5):
		active_words.append(word_array[randi() % word_array.size()])

func process_powerup_entry(entered):
	if entered == active_words[0]:
		get_parent().get_node("Wizard").spell_power += entered.length()
	for i in range(active_words.size()-1):
		active_words[i] = active_words[i+1]
	active_words[-1] = word_array[randi() % word_array.size()]
	update_text()
	
func process_spell_entry(entered):
	for i in range(spell_list.size()):
		if entered == spell_list[i]:
			emit_signal("spell_typed", spell_list[i])

func update_text():
	$verses.bbcode_text = ''
	for i in range(active_words.size()):
		$verses.bbcode_text += active_words[i] + '\n'

signal spell_typed(spell)
