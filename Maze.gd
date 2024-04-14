extends TileMap

@export var sizeX : int = 4
@export var sizeY : int = 4
# Called when the node enters the scene tree for the first time.
var field = []
var frontier = []
var maze

func make_cell():
	var dict = {
		"North" : 1,
		"East" : 1,
		"South" : 1,
		"West" : 1,
		"Visited" : 0
	}
	return dict
func build_filled_maze(x, y):
	var maze = []
	for i in x:
		var row = []
		for j in y:
			row.append(make_cell())
		maze.append(row)
	return maze

func get_unvisited_neighbors(x, y):
	var neighbors = []
	var direction = []
	if x > 0:
		if maze[x-1][y]["Visited"] == 0:
			neighbors.append(Vector2i(x-1, y))
			direction.append("left")
	if x < sizeX:
		if maze[x+1][y]["Visited"] == 0:
			neighbors.append(Vector2i(x+1, y))
			direction.append("right")
	if y > 0:
		if maze[x][y-1]["Visited"] == 0:
			neighbors.append(Vector2i(x, y-1))
			direction.append("down")
	if y < sizeY:
		if maze[x][y+1]["Visited"] == 0:
			neighbors.append(Vector2i(x, y+1))
			direction.append("up")
	var to_return = []
	to_return.append(neighbors)
	to_return.append(direction)
	return neighbors

func remove_wall(base, neighbor, direction):
	if direction == "left":
		maze[base.x][base.y]["West"] = 0
		maze[neighbor.x][neighbor.y]["East"] = 0
	pass
	

func dfs(x, y):
	maze[x][y]["Visted"] = 1
	var val = get_unvisited_neighbors(x, y)
	var unvisited_neighbors = val[0]
	var directions = val[1]
	if unvisited_neighbors.size() > 0:
		var chosen_neighbor = unvisited_neighbors.pick_random()
		var dir = unvisited_neighbors.find(chosen_neighbor)
		remove_wall(Vector2i(x, y), chosen_neighbor, directions[dir])
		dfs(chosen_neighbor.x, chosen_neighbor.y)
	
	
	pass

func set_tile(x,y):
	set_cell(0, Vector2i(x,y), 0, Vector2i(0,0), 0)
	
func gen_maze(w, h):
	maze = build_filled_maze(w, h)
	var start = Vector2i(int(w/2), h)
	dfs(start.x, start.y)
	
	pass

func _ready():
	pass
