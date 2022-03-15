extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	pass


func _on_trigger_body_entered(body):
	#if body == global.persistPlayer:
		#$AnimationPlayer.play("cutscene")
		#global.persistPlayer.cutsceneAnimator.play("moveToLamp")
		#global.persistPlayer.pause()
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "cutscene":
		uiManager.start_battle()
