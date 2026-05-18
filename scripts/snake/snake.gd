extends Node2D

const SCROLL_SPEED: int = 0

var segments: Array[Vector2] = [Vector2(0, 0)]  # list of Vector2 grid positions
var direction: Vector2 = Vector2.UP
var move_timer: float = 0.0
var move_interval: float = 0.2  # seconds between steps
var grid_size: int = 36  # pixels per cell
var changed: bool = false
var food_pos: Vector2
var snake_color: Color = Color.DARK_ORANGE

var mouse_down: Vector2

var score: int = 0

var dead: bool = false
var start: bool = false

func _ready() -> void:
	generate_apple()
	%ScoreLabel.visible = false

func _process(delta: float) -> void:
	move_timer += delta
	if Input.is_action_just_pressed("tap"):
		mouse_down = get_global_mouse_position()
		if not start:
			start = true
			%StartLabel.queue_free()
			%InstructionsLabel.queue_free()
			%ScoreLabel.visible = true
	
	if Input.is_action_just_released("tap"):
		swipe_action()
	
	if move_timer >= move_interval:
		move_timer = 0.0
		if start and not dead:
			move_snake()

func generate_apple() -> void:
	var x: int = randi_range(-360, 360)
	x -= x % grid_size
	var y: int = randi_range(-360, 360)
	y -= y % grid_size
	food_pos = Vector2(x, y)

func move_snake() -> void:
	# Each segment moves to the position of the one ahead of it
	for i: int in range(segments.size() - 1, 0, -1):
		segments[i] = segments[i - 1]
	# Head moves in current direction
	segments[0] += direction * grid_size
	
	queue_redraw()
	if segments[0].y <= (-720.0/2.0) - grid_size:
		segments[0].y = 720.0/2.0 - grid_size
	if segments[0].y >= (720.0/2):
		segments[0].y = -720.0/2
	if segments[0].x <= (-720.0/2.0) - grid_size:
		segments[0].x = 720.0/2.0 - grid_size
	if segments[0].x >= (720.0/2):
		segments[0].x = -720.0/2
	changed = false
	if segments[0] in segments.slice(1):
		dead = true
		if score > Global.snake_high_score:
			Global.snake_high_score = score
		%GameOverScreen.trigger(score, Global.snake_high_score, 20)
		snake_color = Color.DARK_RED
	if segments[0] == food_pos:
		eat_food()
	

func _draw() -> void:
	for seg: Vector2 in segments:
		draw_rect(Rect2(seg, Vector2(grid_size, grid_size)), snake_color)
	draw_rect(Rect2(food_pos, Vector2(grid_size, grid_size)), Color.NAVY_BLUE)

func trigger_movement(dir: String) -> void:
	if changed:
		return
	$MovePlayer.play()
	if dir == "r" and direction != Vector2.LEFT:
		direction = Vector2.RIGHT
	elif dir == "l" and direction != Vector2.RIGHT:
		direction = Vector2.LEFT
	elif dir == "u" and direction != Vector2.DOWN:
		direction = Vector2.UP
	elif dir == "d" and direction != Vector2.UP:
		direction = Vector2.DOWN
	%BackgroundTexture.material.set_shader_parameter("motion",  direction * SCROLL_SPEED)
	changed = true

func swipe_action() -> void:
	var swipeDir: Vector2 = get_global_mouse_position() - mouse_down
	var moveDir: String
	if abs(swipeDir.length()) < 10:
		return
	if abs(swipeDir.x) > abs(swipeDir.y):
		if swipeDir.x > 0:
			moveDir = "r"
		else:
			moveDir = "l"
	else:
		if swipeDir.y > 0:
			moveDir = "d"
		else:
			moveDir = "u"
	trigger_movement(moveDir)

func eat_food() -> void:
	segments.append(segments[-1])
	$FoodPlayer.play()
	score += 1
	%ScoreLabel.text = str(score)
	generate_apple()
