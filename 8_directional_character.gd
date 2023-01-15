extends CharacterBody2D

var current_animation = "idle"
var speed = 200
var angle = 0

func _physics_process(delta):
	current_animation = "idle"
	
	var mouse = get_local_mouse_position()
	angle = snappedf(mouse.angle(), PI / 4) / (PI / 4)
	angle = wrapi(int(angle), 0, 8)
	if Input.is_action_pressed("left_mouse") and mouse.length() > 10:
		current_animation = "run"
		velocity = mouse.normalized() * speed
		move_and_slide()
	$AnimatedSprite2D.animation = current_animation + str(angle)

# Visualize directional calculations
# Press "Tab" to turn on/off debug drawing
var show_debug = false
var font = preload("res://debug/Roboto-Medium.ttf")

func _input(event):
	if event.is_action_pressed("ui_focus_next"):
		show_debug = not show_debug
		queue_redraw()
		
func _draw():
	if not show_debug:
		return
		
	for i in 8:
		draw_line(Vector2.ZERO, Vector2(200, 0).rotated(PI/8 + i * PI/4), Color.GREEN, 5)
		draw_string(font, Vector2(150, 0).rotated(i * PI/4), str(i), 0, -1, 24, Color.WHITE)
	draw_arc(Vector2.ZERO, 200, 0, 2*PI, 200, Color.RED, 5)
		
