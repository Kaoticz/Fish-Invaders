extends Node


@export var mob_scene: PackedScene = load("res://Scenes/Mob.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over():
	$Player.stop()
	$Hud.show_game_over()


func new_game():
	$Player.start(Vector2(70, 200))
	$Player.show()
	$StartTimer.start()
	$Hud.show_message("Get Ready")


func _on_start_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	mob.position = Vector2(500, 300)
	self.add_child(mob)
