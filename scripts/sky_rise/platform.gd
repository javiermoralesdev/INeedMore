class_name SkyRisePlatform
extends AnimatableBody2D

const GRAVITY: float = 75.0
var velocity: Vector2 = Vector2.ZERO

var player: SkyRisePlayer

func _ready() -> void:
	if name == "StartPlatform":
		$Fruit.queue_free()
		return
	var destroy_fruit: bool = randi_range(0, 2) == 0
	if destroy_fruit:
		$Fruit.queue_free()

func _physics_process(delta: float) -> void:
	if player.dead:
		velocity.y = 0
	else:
		velocity.y = GRAVITY
	if player.start and not player.dead:
		move_and_collide(velocity * delta)
	else:
		move_and_collide(Vector2.ZERO)

func _on_death_timer_timeout() -> void:
	queue_free()

func trigger() -> void:
	$DeathTimer.start()


func _on_fruit_body_entered(body: Node2D) -> void:
	if body is not SkyRisePlayer:
		return
	(body as SkyRisePlayer).add_score(1)
	$Fruit.queue_free()
