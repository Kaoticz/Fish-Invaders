extends Node
## This class defines the behavior of the main game scene.


## The mob scene.
var mob_scene: PackedScene = load("res://Scenes/Mob.tscn")

## The initial position of the mobs.
var mob_positions: Array[Vector2] = [
	Vector2(500, 50),
	Vector2(500, 125),
	Vector2(500, 200),
	Vector2(500, 275),
	Vector2(500, 350),
	Vector2(600, 50),
	Vector2(600, 125),
	Vector2(600, 200),
	Vector2(600, 275),
	Vector2(600, 350)
]


## Start method, called when this node enters the scene tree for the first time.
func _ready() -> void:
	pass


## Update method, runs on every frame.
## delta: The elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


## Stops gameplay, shows game-over screen and returns to the main menu.
func game_over():
	$Player.stop()
	$Hud.show_game_over()
	get_tree().call_group("mobs", "queue_free")


## Initializes a new game session.
func new_game():
	$Player.start(Vector2(70, 200))
	$Player.show()
	$StartTimer.start()
	$Hud.show_message("Get Ready")


## Spawns the mobs when the $MessageTimer ticks.
func _on_start_timer_timeout() -> void:
	for position in mob_positions:
		var mob = mob_scene.instantiate()
		mob.position = position
		self.add_child(mob)
