class_name GameManager
extends Node2D


# scenes
var _main_menu_scene := preload("res://components/main_menu/main_menu.tscn")
var _main_menu_instance: MainMenu

var _play_scene := preload("res://components/initial_test/initial_test.tscn")
var _play_instance: Node2D

# managers
var _multiplayer_manager: MultiplayerManager


func _ready() -> void:
    _main_menu_instance = _main_menu_scene.instantiate() as MainMenu
    add_child(_main_menu_instance)

    _main_menu_instance.host_button.pressed.connect(_on_host_button_pressed)
    _main_menu_instance.join_button.pressed.connect(_on_join_button_pressed)
    _main_menu_instance.start_button.pressed.connect(_on_start_button_pressed)


@rpc("authority", "call_local", "reliable")
func Start():
    _main_menu_instance.queue_free()
    _main_menu_instance = null

    _play_instance = _play_scene.instantiate() as Node2D
    add_child(_play_instance)


func _on_host_button_pressed() -> void:
    # clear manager or early return
    if _multiplayer_manager:
        if _multiplayer_manager.mode == MultiplayerManager.MultiplayerMode.HOST:
            return
        else:
            _multiplayer_manager.queue_free()

    _multiplayer_manager = MultiplayerManager.new(MultiplayerManager.MultiplayerMode.HOST)
    add_child(_multiplayer_manager)
    _multiplayer_manager.name = "MultiplayerManager"


func _on_join_button_pressed() -> void:
    # clear manager
    if _multiplayer_manager and _multiplayer_manager.mode != MultiplayerManager.MultiplayerMode.CLIENT:
        _multiplayer_manager.queue_free()

    _multiplayer_manager = MultiplayerManager.new(MultiplayerManager.MultiplayerMode.CLIENT)
    add_child(_multiplayer_manager)
    _multiplayer_manager.name = "MultiplayerManager"


func _on_start_button_pressed() -> void:
    Start.rpc()
