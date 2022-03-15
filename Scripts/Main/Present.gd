extends Area2D

export (String) var flag = ""
export (String) var itemID = "0"

var player = null
var inReach = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	if inReach == true:
		if uiManager.commandsMenuActive == true:
			if Input.is_action_just_pressed("ui_accept"):
					print("ur mum2")
					if globaldata.flags[flag] == false:
						$Sprite.frame = 1

func _on_Present_area_entered(area):
	if area.name == "EventDetector":
		inReach = true
	else:
		inReach = false

func _on_Present_area_exited(area):
	inReach = false
