class_name PlayerController
extends CharacterBody2D


const SPEED := 300.0


@export var player := 1 :
    set(id):
        player = id
        $PlayerInput.set_multiplayer_authority(id)

@onready var _input := $PlayerInput as PlayerInput


func _ready() -> void:
    update_color()
    if player == multiplayer.get_unique_id():
        $Camera2D.make_current()
    # NOTE: uncomment to stop player-side simulation.
    #set_physics_process(multiplayer.is_server())


func _physics_process(delta: float) -> void:
    velocity = _input.direction * SPEED
    move_and_slide()


func update_color() -> void:
    var color_idx := multiplayer.get_peers().size() % 4
    var texture := $Sprite2D.texture as AtlasTexture
    $Sprite2D.texture = texture.duplicate()
    texture.region.position.x += color_idx * 64 * 2
