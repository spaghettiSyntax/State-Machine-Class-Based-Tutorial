extends Node

var is_walking
var is_jumping
var is_hurt
var is_attacking

func _physics_process(_delta: float) -> void:
	if is_walking \
		and not is_jumping \
		and not is_hurt \
		and not is_attacking:
			play_animation("walk")
	elif is_jumping \
		and not is_walking \
		and not is_hurt \
		and not is_attacking:
			play_animation("jump")
	elif is_attacking \
		and not is_hurt \
		and not is_jumping \
		and not is_walking:
			play_animation("attack")
	elif is_hurt \
		and not is_attacking \
		and not is_jumping \
		and not is_walking:
			play_animation("hurt")
	elif is_walking \
		and is_jumping \
		and not is_hurt \
		and not is_attacking:
			play_animation("walk")  
			# or jump? idk
	else:
		pass  # we'll fix this later
		# (we will not fix this later)
		
		
		
		
		
		
		
		
func play_animation(animation: String) -> void:
	pass
