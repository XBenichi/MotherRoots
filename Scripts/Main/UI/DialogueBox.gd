extends CanvasLayer

export(float) var textSpeed = 0.02

var dialog

var phraseNum = 0
var finished = false

func _ready():
	$Timer.wait_time = textSpeed
	dialog = getDialog()
	
	nextPhrase()
	

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase()
		else:
			$Dialoguebox/Dialogue.visible_characters = len($Dialoguebox/Dialogue.text)
	
	if $Dialoguebox/Namebox/Name.text == "":
		$Dialoguebox/Namebox.hide()
	else:
		$Dialoguebox/Namebox.show()

func getDialog() -> Array:
	var f = File.new()

	if f.file_exists(global.dialogue):
		pass
	else:
		global.set_dialog("error")

	f.open(global.dialogue, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []

func nextPhrase() -> void:
	if phraseNum >= len(dialog):
		$Dialoguebox/Dialogue.visible_characters = 0
		uiManager.remove_ui(self)
		uiManager.commandsMenuActive = true
		phraseNum = 0
		return
	
	finished = false
	
	if phraseNum == 0:
		$Dialoguebox/Dialogue.remove_line(1)
	
	$Dialoguebox/Namebox/Name.bbcode_text = dialog[phraseNum]["name"]
	if $Dialoguebox/Dialogue.bbcode_text == "":
		$Dialoguebox/Dialogue.bbcode_text = dialog[phraseNum]["text"]
	else:
		$Dialoguebox/Dialogue.bbcode_text = $Dialoguebox/Dialogue.bbcode_text + "\n" + dialog[phraseNum]["text"]
	
	
	if $Dialoguebox/Namebox/Name.bbcode_text == "":
		$Dialoguebox/Dialogue.rect_size = Vector2(147, 57)
		$Dialoguebox/Dialogue.rect_position = Vector2(5, 5)
	else:
		$Dialoguebox/Dialogue.rect_size = Vector2(147, 57)
		$Dialoguebox/Dialogue.rect_position = Vector2(5, 10)
	
	while $Dialoguebox/Dialogue.visible_characters < len($Dialoguebox/Dialogue.text):
		$Dialoguebox/Dialogue.visible_characters += 1
		$Dialoguebox/Dialogue.scroll_to_line($Dialoguebox/Dialogue.get_line_count()-1)
		$Timer.start()
		yield($Timer, "timeout")
	
	finished = true
	phraseNum += 1
	return
