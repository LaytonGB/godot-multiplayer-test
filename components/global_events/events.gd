extends Node

signal join_pressed
signal host_pressed
signal start_pressed

func _on_join_pressed() -> void:
    join_pressed.emit()

func _on_host_pressed() -> void:
    host_pressed.emit()

func _on_start_pressed() -> void:
    start_pressed.emit()

