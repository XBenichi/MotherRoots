extends Sprite


export (String) var dialog
export (String) var sprite
var player = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	set_spritesheet()



func interact(interactor):
	pass
	#if not is_instance_valid(dialogue_box) and uiManager.ui_stack.size() == 0:
		#var lines = GlobalData.get_npc_dialog(interact_id, interact_direction(interactor))
		#if lines:
			#dialogue_box = ui_manager.dialogue_box(lines)
			#return true

func _dialogstart():
	pass

func _on_Area2D_body_entered(body):
	player = body
	if player == global.persistPlayer:
		global.set_dialog(dialog)
		

func _on_Area2D_body_exited(body):
	global.set_dialog("noproblem")

func set_spritesheet():
	if sprite != "":
		self.texture = load("res://Graphics/Character Sprites/Npcs/" + sprite + "/main.png")
	else:
		self.hide()

