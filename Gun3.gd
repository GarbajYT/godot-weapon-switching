extends MeshInstance

func _ready():
	pass

func shoot():
	if Input.is_action_just_pressed("fire"):
		print("Gun3 Fired")
