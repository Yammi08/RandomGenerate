extends Node2D

export (int) var width;
export (int) var height;
export (bool) var calculateSize;
var cellX;
var cellY;
var indicates = Dictionary();
var maps = [];

func _enter_tree():
	var childrens = get_children();
	for child in childrens:
		if child.is_in_group("Door"):
			indicates.keys().append(child.name);
			indicates[child.name] = child;
		elif child.is_in_group("Tile"):
			maps.append(child);
	
	if calculateSize:
		CalculateSize();
	

func CalculateSize():
	width = 0;
	height = 0;
	var cellX;
	var cellY;
	for map in maps:
		var widthMap = (map.get_used_cells()[map.get_used_cells().size()-1].x+1)*map.cell_size.x;
		var heightMap = (map.get_used_cells()[map.get_used_cells().size()-1].y+1)*map.cell_size.y;
		if(width < widthMap):
			width = widthMap;
			cellX = map.cell_size.x;
		if(height < heightMap):
			height = heightMap;
			cellX = map.cell_size.y;
	
	for ind in indicates:
		if(width < ind.position.x):
			width = ind.position.x;
		if(height < ind.position.y):
			height = ind.position.y;
