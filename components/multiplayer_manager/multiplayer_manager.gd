class_name MultiplayerManager
extends Node


enum MultiplayerMode {HOST, CLIENT}

@export var _max_players := 5

const _ip := "127.0.0.1"
const _port := 8910

var mode: MultiplayerMode


func _init(mode: MultiplayerMode) -> void:
    self.mode = mode


func _ready() -> void:
    multiplayer.peer_connected.connect(_peer_connected)
    multiplayer.peer_disconnected.connect(_peer_disconnected)
    multiplayer.connected_to_server.connect(_connected_to_server)
    multiplayer.server_disconnected.connect(_server_disconnected)

    var peer := ENetMultiplayerPeer.new()
    match mode:
        MultiplayerMode.HOST: peer.create_server(_port)
        MultiplayerMode.CLIENT: peer.create_client(_ip, _port)
    if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
        OS.alert("Failed to start multiplayer server.")
        return
    multiplayer.multiplayer_peer = peer


func _peer_connected(id: int) -> void:
    print("Peer connected: ", id)


func _peer_disconnected(id: int) -> void:
    print("Peer disconnected: ", id)


func _connected_to_server() -> void:
    print("Connected to server")


func _server_disconnected() -> void:
    print("Disconnected from server")
