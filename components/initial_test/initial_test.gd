extends Node2D

const _spawn_area_radius := 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    if not multiplayer.is_server():
        return

    multiplayer.peer_connected.connect(add_player)
    multiplayer.peer_disconnected.connect(del_player)

    for id in multiplayer.get_peers():
        add_player(id)

    if "--server" not in OS.get_cmdline_args():
        add_player(1)


func _exit_tree():
    if not multiplayer.is_server():
        return
    multiplayer.peer_connected.disconnect(add_player)
    multiplayer.peer_disconnected.disconnect(del_player)


func add_player(id: int) -> void:
    var character := preload("res://components/player/player.tscn").instantiate() as PlayerController
    character.player = id
    var pos := Vector2.from_angle(randf() * 2 * PI)
    character.position = $SpawnAreaCenter.position + pos * _spawn_area_radius * randf()
    character.name = str(id)
    $Players.add_child(character, true)


func del_player(id: int) -> void:
    if not $Players.has_node(str(id)):
        return
    $Players.get_node(str(id)).queue_free()
