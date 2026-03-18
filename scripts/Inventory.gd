extends Node

var map_pieces = []

signal map_piece_added(id)

func add_map_piece(id):
	if id not in map_pieces:
		map_pieces.append(id)
		emit_signal("map_piece_added", id)

func has_all_pieces():
	return map_pieces.size() >= 4
