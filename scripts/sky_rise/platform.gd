extends AnimatableBody2D

const GRAVITY: float = 75.0
var velocity: Vector2 = Vector2.ZERO

var player: SkyRisePlayer

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity.y = GRAVITY
	if player.start and not player.dead:
		move_and_collide(velocity * delta)
	
		
	
