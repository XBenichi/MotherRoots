extends Node

var commandsMenuTemplate = load("res://Nodes/Ui/Pause menu.tscn")
var dialogueBoxTemplate = load("res://Nodes/Ui/DialogueBox.tscn")
var battleMenuTemplate = load("res://Nodes/Ui/Battle/Battle.tscn")
var battleTransition = load("res://Nodes/Ui/Battle/Battle Transition.tscn")
var commandsMenu
var commandsMenuActive = false
var uiActive = false
var fade = null
var stableCanvasLayer = null
var uiStack = []
var uitext

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	var canvasLayerTemplate = load("res://Nodes/Ui/mainCanvasLayer.tscn")
	
	if stableCanvasLayer == null:
		stableCanvasLayer = canvasLayerTemplate.instance()
		global.currentScene.add_child(stableCanvasLayer)
		global.add_persistent(stableCanvasLayer)
	
	if fade == null:
		var transitionTemplate = load("res://Nodes/Ui/effects/Fade.tscn")
		var transition = transitionTemplate.instance()
		transition.set_name("fade")
		stableCanvasLayer.add_child(transition)
		fade = transition
	
	if uiStack.size() > 0:
		uiActive = true
	else:
		if Input.is_action_just_pressed("ui_accept"):
			pass
		uiActive = false
		return
func add_ui(ui, addChild = true):
	uiStack.push_front(ui)
	if addChild:
		stableCanvasLayer.add_child(ui)

func remove_ui(ui=uiStack[0]):
	if ui in uiStack:
		uiStack.erase(ui)
	if is_instance_valid(ui):
		close_item(ui)

func close_current():
	remove_ui()

func close_item(item):
	if item.has_method('close'):
		item.close()
	else:
		item.queue_free()

func open_dialogue_box():
	var dialogueBox = dialogueBoxTemplate.instance()
	add_ui(dialogueBox)
	commandsMenuActive = false

func open_commands_menu():
	commandsMenu = commandsMenuTemplate.instance()
	add_ui(commandsMenu)
	commandsMenuActive = true
	

func start_battle():
	var transition = battleTransition.instance()
	add_ui(transition)
	commandsMenuActive = false

func add_to_canvas(node, layer=0):
	stableCanvasLayer.add_child(node)
	if layer != -1:
		stableCanvasLayer.move_child(node, layer)
