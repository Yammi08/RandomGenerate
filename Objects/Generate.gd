extends Node
export(Array, PackedScene) var rooms;
export(int) var numberRooms; 
var size;


func _ready():
	size = int(numberRooms);
	var map = Map.new(self,size,numberRooms);

class Map:
	enum turtledir{
		stop =0,
		left=1,
		right=2,
		up=3,
		down=4
	}
	var size;
	var map;
	var activeRooms;
	var rooms;
	var this;
	func _init(this:Node,size:int,rooms:int):
		seed(10);
		self.this = this;
		self.size = size;
		self.map = [];
		self.rooms = rooms;
		self.activeRooms = [];
		_inicializateMap();
		_createMap();
		#for r in map:
		#	print(r);
		_drawRooms();
	func _inicializateMap():
		for y in range(self.size):
			self.map.append([]);
			for x in range(self.size):
				map[y].append("00000"); #primer 0 se activa si la habitacion existe segundo 0 se activa si hay una habitacion arriba
	func _createMap():
		var position = Vector2(((size/2)-1)+(randi()%3),((size/2)-1)+(randi()%3));
		var startpos = position;
		var roomr = 0;
		self.map[position.y][position.x][0] = '1';
		activeRooms.append(position);
		for room in self.rooms/2:
			self.map[position.y][position.x];
			var roomnext = randi()%5;
			var dir : Vector2;
			var posnext:Vector2;
			var posnexfor2:Vector2;
			if(roomnext == turtledir.stop):
				position = startpos;
				roomnext += (randi()%5 + 1)%5;
			match(roomnext):
				turtledir.right:
					dir = Vector2(1,0);
					if(position.y +dir.x*2 > size):
						roomr += 2;
						continue
				turtledir.left:
					dir = Vector2(-1,0);
					if(position.y +dir.x*2 < 0):
						roomr += 2;
						continue
				turtledir.up:
					dir = Vector2(0,-1);
					if(position.y +dir.y*2 < 0):
						roomr += 2;
						continue
				turtledir.down:
					dir = Vector2(0,1);
					if(position.y +dir.y*2 > size):
						roomr += 2;
						continue
			
			posnext =  position + dir; #posicion + 1;
			if(map[posnext.y][posnext.x][0] == '0'):
				posnexfor2 = position + dir * 2; #posicion + 2;
				map[position.y][position.x][roomnext] = '1';
				map[posnext.y][posnext.x][roomnext] = '1';
				map[posnext.y][posnext.x][roomnext-(dir.x+dir.y)] = '1';
				map[posnext.y][posnext.x][0] = '1';
				map[posnexfor2.y][posnexfor2.x][roomnext-(dir.x+dir.y)] = '1';
				map[posnexfor2.y][posnexfor2.x][0] = '1';
				activeRooms.append(Vector2(posnext.x,posnext.y));
				activeRooms.append(Vector2(posnexfor2.x,posnexfor2.y));
				position += dir*2;
			else:
				roomr += 2;
		_extraRooms(roomr);
	func _extraRooms(roomr:int):
		for room in range(roomr):
			var roomnext = randi()%activeRooms.size();
			var coord = activeRooms[roomnext];
			if(map[coord.y][coord.x][turtledir.right] != '1'):
				map[coord.y][coord.x+1][0] = '1';
				map[coord.y][coord.x+1][turtledir.left] = '1';
				map[coord.y][coord.x][turtledir.right] = '1';
				activeRooms.append(Vector2(coord.x+1,coord.y));
			elif(map[coord.y][coord.x][turtledir.left] != '1'):
				map[coord.y][coord.x-1][0] = '1';
				map[coord.y][coord.x-1][turtledir.right] = '1';
				map[coord.y][coord.x][turtledir.left] = '1';
				activeRooms.append(Vector2(coord.x-1,coord.y));
			elif(map[coord.y][coord.x][turtledir.up] != '1'):
				map[coord.y][coord.x-1][0] = '1';
				map[coord.y][coord.x-1][turtledir.down] = '1';
				map[coord.y][coord.x][turtledir.up] = '1';
				activeRooms.append(Vector2(coord.x,coord.y-1));
			elif(map[coord.y][coord.x][turtledir.down] != '1'):
				map[coord.y][coord.x+1][0] = '1';
				map[coord.y][coord.x+1][turtledir.up] = '1';
				map[coord.y][coord.x][turtledir.down] = '1';
				activeRooms.append(Vector2(coord.x,coord.y+1));
		
	
	func _drawRooms():
		for i in range(activeRooms.size()):
			var num = randi()%this.rooms.size();
			var createRoom = this.rooms[num].instance();
			this.add_child(createRoom);
			var doorsO = map[activeRooms[i].y][activeRooms[i].x];
			if(doorsO[turtledir.right] == '1'):
				createRoom.indicates['Right'].queue_free();
			if(doorsO[turtledir.left] == '1'):
				createRoom.indicates['Left'].queue_free();
			if(doorsO[turtledir.up] == '1'):
				createRoom.indicates['Up'].queue_free();
			if(doorsO[turtledir.down] == '1'):
				createRoom.indicates['Down'].queue_free();
			createRoom.position = Vector2(createRoom.width,createRoom.height)*activeRooms[i] - Vector2(size*size,size*size);
