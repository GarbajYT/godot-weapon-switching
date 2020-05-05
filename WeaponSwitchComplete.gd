extends KinematicBody

var speed = 7
var acceleration = 10
var gravity = 0.09
var jump = 10

var mouse_sensitivity = 0.03

var direction = Vector3()
var velocity = Vector3()
var fall = Vector3() 

var current_weapon = 1

onready var head = $Head
onready var gun1 = $Head/Hand/Gun1
onready var gun2 = $Head/Hand/Gun2
onready var gun3 = $Head/Hand/Gun3

func _ready():
	pass
	
func _input(event):
	
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity)) 
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity)) 
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))
		
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				if current_weapon < 3:
					current_weapon += 1
				else:
					current_weapon = 1
			elif event.button_index == BUTTON_WHEEL_DOWN:
				if current_weapon > 1:
					current_weapon -= 1
				else:
					current_weapon = 3
		
func weapon_select():
	
	if Input.is_action_just_pressed("weapon1"):
		current_weapon = 1
	elif Input.is_action_just_pressed("weapon2"):
		current_weapon = 2
	elif Input.is_action_just_pressed("weapon3"):
		current_weapon = 3
		
	if current_weapon == 1:
		gun1.visible = true
		gun1.shoot()
	else:
		gun1.visible = false

	if current_weapon == 2:
		gun2.visible = true
		gun2.shoot()
	else:
		gun2.visible = false

	if current_weapon == 3:
		gun3.visible = true
		gun3.shoot()
	else:
		gun3.visible = false

func _physics_process(delta):
	
	weapon_select()
	
	direction = Vector3()
	
	move_and_slide(fall, Vector3.UP)
	
	if not is_on_floor():
		fall.y -= gravity
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		fall.y = jump
		
	
	if Input.is_action_pressed("move_forward"):
	
		direction -= transform.basis.z
	
	elif Input.is_action_pressed("move_backward"):
		
		direction += transform.basis.z
		
	if Input.is_action_pressed("move_left"):
		
		direction -= transform.basis.x			
		
	elif Input.is_action_pressed("move_right"):
		
		direction += transform.basis.x
			
		
	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta) 
	velocity = move_and_slide(velocity, Vector3.UP) 

