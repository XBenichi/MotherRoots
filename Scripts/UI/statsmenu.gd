extends CanvasLayer


onready var first = $Melodies/spots/first/note
onready var second = $Melodies/spots/second/note
onready var third = $Melodies/spots/third/note
onready var fourth = $Melodies/spots/fourth/note
onready var fifth = $Melodies/spots/fifth/note
onready var sixth = $Melodies/spots/sixth/note
onready var seventh = $Melodies/spots/seventh/note
onready var eighth = $Melodies/spots/eighth/note

var active = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	#melody group
	if active:
		match(globaldata.flags["doll_melody"]):
			false:
				first.hide()
			true:
				first.show()
		match(globaldata.flags["canary_melody"]):
			false:
				second.hide()
			true:
				second.show()
		match(globaldata.flags["zoo_melody"]):
			false:
				third.hide()
			true:
				third.show()
		match(globaldata.flags["piano_melody"]):
			false:
				fourth.hide()
			true:
				fourth.show()
		match(globaldata.flags["cactus_melody"]):
			false:
				fifth.hide()
			true:
				fifth.show()
		match(globaldata.flags["dragon_melody"]):
			false:
				sixth.hide()
			true:
				sixth.show()
		match(globaldata.flags["eve_melody"]):
			false:
				seventh.hide()
			true:
				seventh.show()
		match(globaldata.flags["grave_melody"]):
			false:
				eighth.hide()
			true:
				eighth.show()
	
	if Input.is_action_just_pressed("ui_cancel"):
		uiManager.stableCanvasLayer.remove_child(self)
		uiManager.commandsMenuActive = true
