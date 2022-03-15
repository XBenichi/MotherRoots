extends Control


onready var animationPlayer = $CanvasLayer/AnimationPlayer
onready var label = $CanvasLayer/Aboveground/Base/Label
var active = false
var option = 0


func _ready():
	label.text = "Originally Produced by"
	animationPlayer.play("nintendo")
	

func _process(delta):
	global.persistPlayer.pause()
	if active:
		if Input.is_action_just_pressed("ui_down"):
			option = option + 1
		elif Input.is_action_just_pressed("ui_up"):
			option = option - 1
		
		match(option):
			-1:
				option = 2
			0:
				$CanvasLayer/Title/Menu/Start.text = ">Start<"
				$CanvasLayer/Title/Menu/Options.text = "Options"
				$CanvasLayer/Title/Menu/STest.text = "Sound Test"
			1:
				$CanvasLayer/Title/Menu/Start.text = "Start"
				$CanvasLayer/Title/Menu/Options.text = ">Options<"
				$CanvasLayer/Title/Menu/STest.text = "Sound Test"
			2:
				$CanvasLayer/Title/Menu/Start.text = "Start"
				$CanvasLayer/Title/Menu/Options.text = "Options"
				$CanvasLayer/Title/Menu/STest.text = ">Sound Test<"
			3:
				option = 0
		
		if Input.is_action_just_pressed("ui_accept"):
			match(option):
				0:
					global.persistPlayer.position = Vector2(315,5)
					global.persistPlayer.unpause()
	if Input.is_action_just_pressed("ui_cancel"):
			match(option):
				0:
					global.persistPlayer.position = Vector2(315,5)
					global.persistPlayer.unpause()
	
func _on_AnimationPlayer_animation_finished(anim_name):
	match(anim_name):
		"nintendo":
			animationPlayer.play("itoi")
			label.text = "Originally Presented by"
		"itoi":
			animationPlayer.play("Roots team")
			label.text = "Presented by"
		"Roots team":
			$CanvasLayer/Aboveground/Base.hide()
			animationPlayer.play("Fade")
		"Fade":
			$CanvasLayer/Title/Menu.show()
			active = true
