extends KinematicBody2D

var inputVector = Vector2.ZERO
export (int) var spacing = 20
var delay = 0.2

onready var sprite = $main
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")


# warning-ignore:unused_argument
func _process(delta):
	if global.partySpace[spacing] != null:
		self.position = global.partySpace[spacing]
		var player = global.persistPlayer
		$Timer.wait_time = delay
		if player.walk == true:
			animationTree.set("parameters/Idle/blend_position", inputVector)
			animationTree.set("parameters/Walk/blend_position", inputVector)
			animationState.travel("Walk")
		else:
			animationState.travel("Idle")
		if player.paused:
			animationState.travel("Idle")


func _on_Timer_timeout():
	if global.persistPlayer.walk == true:
		inputVector = global.persistPlayer.inputVector
