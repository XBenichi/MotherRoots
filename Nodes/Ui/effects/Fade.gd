extends ColorRect

var callback_node = null
var callback_method = null

func fade_out(animation_speed = 1.5, callback_node = null, callback_method = null):
	$AnimationPlayer.play("Fade Out", -1, animation_speed)
	self.callback_node = callback_node
	self.callback_method = callback_method
	
func fade_in(animation_speed = 1.5, callback_node = null, callback_method = null):
	$AnimationPlayer.play("Fade In", -1, animation_speed)
	self.callback_node = callback_node
	self.callback_method = callback_method
	

func _on_AnimationPlayer_animation_finished(anim_name):
	if callback_node and callback_method:
		if callback_node.has_method(callback_method):
			callback_node.call(callback_method)
			

