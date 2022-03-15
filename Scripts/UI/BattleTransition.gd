extends CanvasLayer


onready var animationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animationPlayer.play("Start")
	global.persistPlayer.pause()
	uiManager.commandsMenuActive = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	uiManager.fade.fade_out()
	if anim_name == "Start":
		var battleui = uiManager.battleMenuTemplate.instance() 
		uiManager.add_ui(battleui)
		battleui.update_party()
		uiManager.remove_ui(self)


