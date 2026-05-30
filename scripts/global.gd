extends Node

const SAVE_PATH: String = "user://save.tres"

const FLAP_SPACE_TARGET: int = 20
const SPACE_RUN_TARGET: int = 20
const SNAKE_TARGET: int = 20
const SKY_RISE_TARGET: int = 5
const FINAL_BATTLE_TARGET: int = 30

var free_mode: bool = false

var minigames: Dictionary = {
	1: "flap_space",
	2: "space_run",
	3: "snake",
	4: "sky_rise",
	5: "final_battle"
}

var flap_space_high_score: int = 0
var space_run_high_score: int = 0
var snake_high_score: int = 0
var skyrise_high_score: int = 0
var final_battle_high_score: int = 0
var day: int = 1
var free_mode_day: int = 1
var music_volume: float = 0
var sound_volume: float = 0
var ambient_volume: float = 0
var fullscreen: bool = false
var language: String = ""

func _ready() -> void:
	load_game()
	Dialogic.VAR.flap_space_target = FLAP_SPACE_TARGET
	Dialogic.VAR.space_run_target = SPACE_RUN_TARGET
	Dialogic.VAR.snake_target = SNAKE_TARGET
	Dialogic.VAR.sky_rise_target = SKY_RISE_TARGET
	Dialogic.VAR.final_battle_target = FINAL_BATTLE_TARGET

func save_game() -> void:
	var data: SaveData = SaveData.new()
	data.flap_space_high_score = flap_space_high_score
	data.space_run_high_score = space_run_high_score
	data.snake_high_score = snake_high_score
	data.skyrise_high_score = skyrise_high_score
	data.final_battle_high_score = final_battle_high_score
	data.day = day
	data.free_mode_day = free_mode_day
	data.sound_volume = sound_volume
	data.music_volume = music_volume
	data.fullscreen = fullscreen
	data.ambient_volume = ambient_volume
	data.language = language
	ResourceSaver.save(data, SAVE_PATH)

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	
	var data: SaveData = ResourceLoader.load(SAVE_PATH)
	flap_space_high_score = data.flap_space_high_score
	space_run_high_score = data.space_run_high_score
	snake_high_score = data.snake_high_score
	skyrise_high_score = data.skyrise_high_score
	final_battle_high_score = data.final_battle_high_score
	day = data.day
	free_mode_day = data.free_mode_day
	sound_volume = data.sound_volume
	music_volume = data.music_volume
	fullscreen = data.fullscreen
	ambient_volume = data.ambient_volume
	language = data.language
	update_settings(music_volume, sound_volume, ambient_volume, fullscreen, language)

func go_to_minigame(target: String) -> void:
	Transition.transition()
	await Transition.transition_finished
	get_tree().change_scene_to_file("res://scenes/" + target +  "/" + target + ".tscn")

func update_settings(p_music_volume: float, p_sound_volume: float, p_ambient_volume: float, p_fullscreen: bool, p_language: String) -> void:
	sound_volume = p_sound_volume
	music_volume = p_music_volume
	ambient_volume = p_ambient_volume
	fullscreen = p_fullscreen
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(music_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), linear_to_db(sound_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambient"), linear_to_db(ambient_volume))
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	language = p_language
	if language != "":
		TranslationServer.set_locale(language)
	

func open_url(url: String) -> void:
	OS.shell_open(url)

func change_scene(scene: String) -> void:
	Transition.transition()
	await Transition.transition_finished
	get_tree().change_scene_to_file("res://scenes/" + scene + ".tscn")
