extends Node2D

@export var width:int=300
@export var height:int=300

@export var terrain:FastNoiseLite=FastNoiseLite.new()
@export var biomes:FastNoiseLite=FastNoiseLite.new()
@export var ores:FastNoiseLite=FastNoiseLite.new()

var biomes_list:Array=[]
var ores_list:Array=[]

func generate_world():

	for x in range(-width/2,width/2):
		for y in range(-height/2,height/2):
			var biomes_val=biomes.get_noise_2d(x,y)
			var terrain_val=terrain.get_noise_2d(x,y)
			var ores_val=ores.get_noise_2d(x,y)
			
			if biomes_val>0.04 and biomes_val<0.38 and terrain_val>0.13:
				biomes_list.append([Vector2(x,y),1])
				print("vulcan")
				if ores_val>0.7:
					ores_list.append([Vector2(x,y),2])
				elif ores_val>0.5:
					ores_list.append([Vector2(x,y),0])
			if biomes_val>0.2 and biomes_val<0.8 and terrain_val>0.13:
				biomes_list.append([Vector2(x,y),0])
				
				if 0.4<ores_val and ores_val<0.54:
					ores_list.append([Vector2(x,y),1])
				if 0.4<ores_val and ores_val>0.54:
					ores_list.append([Vector2(x,y),0])
			$Map.set_cell(0,Vector2(x,y),1,Vector2(13,1))
	var flat=[]
	var vulcan=[]
	for vec in biomes_list:
		if vec[1]==0:
			flat.append(vec[0])
		if vec[1]==1:
			vulcan.append(vec[0])
	$Map.set_cells_terrain_connect(1,flat,0,0)
	$Map.set_cells_terrain_connect(1,vulcan,1,0)
	
func _ready():
	generate_world()

