extends RichTextLabel

var current_text = "-"
var current_letter = 0
var spell_power = 0
var file = File.new()
var word_array := []

func _ready():
	OS.set_ime_active(true)
	file.open("res://test_list.txt", file.READ)
	while not file.eof_reached():
		word_array.append(file.get_line())
	var content = file.get_as_text()

# handle all unassigned typed input
func _unhandled_input(event: InputEvent) -> void:
	#if event is a key pres and if still pressed and not a repeat (held)
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		print(event.scancode, "   ", event.unicode)
		# save as a string
		var key_typed = PoolByteArray([event.unicode]).get_string_from_utf8()
		# if space entered, check powerup list
		if event.unicode == 32:
			get_parent().get_node("Tome").process_powerup_entry(bbcode_text)
			bbcode_text = ''
		# if Enter entered, check powerup list
		elif event.scancode == 16777221:
			get_parent().get_node("Tome").process_spell_entry(bbcode_text)
			bbcode_text = ''
		elif event.scancode == 16777220:
			bbcode_text = bbcode_text.substr(0, bbcode_text.length() - 1)
		else: 
			bbcode_text += key_typed
	
#	# if event is a key pres and if still pressed and not a repeat (held)
#	if event is InputEventKey and event.is_pressed() and not event.is_echo():
#		# save as a string
#		var key_typed = PoolByteArray([event.unicode]).get_string_from_utf8()
#		# print(event.unicode)
#		# if current place in text is not exceeding length of given text and if a visible character and not a number
#		if current_letter < plain_text.length() and (event.unicode >= 33 and event.unicode <= 126) and not (event.unicode >= 48 and event.unicode <= 57):
#			# if next letter is space, skip ahead
#			if ' ' == plain_text[current_letter]:
#				current_letter += 1
#				get_parent().get_node("Wizard").spell_power += 5
#			# if the letter typed matches the current place show all finished text as white
#			if key_typed == plain_text[current_letter]:
#				formatted_text = '[color=white]' + plain_text.substr(0, current_letter+1) + '[/color]' + plain_text.substr(current_letter + 1, -1)
#				current_letter += 1
#				get_parent().get_node("Wizard").spell_power += 0.5
#				# give a large sum of spell power once sentence is complete
#				if current_letter >= plain_text.length():
#					get_parent().get_node("Wizard").spell_power += 20
#					current_letter = 0
#			# if incorrect input give white text with red on incorrect char
#			else: 
#				formatted_text = '[color=white]' + plain_text.substr(0, current_letter) + '[/color][color=red][shake rate=30 level=8]' + plain_text.substr(current_letter, 1) + '[/shake][/color]' + plain_text.substr(current_letter+1, -1)
#			# update text to formatted text
#			$RichTextLabel.bbcode_text = formatted_text
