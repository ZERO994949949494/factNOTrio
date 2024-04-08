extends TileMap

@onready var tilemap=$Map

@export var noise_texture:NoiseTexture2D
@export var biomes_noise_texture:NoiseTexture2D
@export var ore_noise_texture:NoiseTexture2D

var terrain=[]
var ore=[]


var noise:Noise
var orenoise:Noise
var biomesnoise:Noise

var width:int=300
var height:int=300

func _ready():
	noise=noise_texture.noise
	orenoise=ore_noise_texture.noise
	biomesnoise=biomes_noise_texture.noise
	generate_world()
func generate_world():
	var noise_val
	var ore_noise_val
	var biomes_noise_val
	for x in range(-width/2,width/2):
		for y in range(-height/2,height/2):
			noise_val=noise.get_noise_2d(x,y)
			ore_noise_val=orenoise.get_noise_2d(x,y)
			biomes_noise_val=biomesnoise.get_noise_2d(x,y)
			
			if biomes_noise_val>0.7:
				pass #vulkan biome
