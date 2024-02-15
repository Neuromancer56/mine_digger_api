

function dig_area(StartPosition, X_size, Y_size, Z_size, DigAlongAxis, ReplaceWith, PlaceNode, PlaceLocation)
    minetest.log("hello","start")
	local EndPosition = vector.new(StartPosition.x, StartPosition.y, StartPosition.z)
	
    -- Adjust the start and end positions based on the DigAlongAxis and sizes
    if DigAlongAxis == 'X' then
        EndPosition.x = EndPosition.x + X_size
    elseif DigAlongAxis == 'Y' then
        EndPosition.y = EndPosition.y + Y_size
    elseif DigAlongAxis == 'Z' then
        EndPosition.z = EndPosition.z + Z_size
    end
		DigEndPositionX= StartPosition.x + X_size
		DigEndPositionY= StartPosition.y + Y_size
		DigEndPositionZ= StartPosition.z + Z_size

    -- Dig out the area and replace nodes
	    minetest.log("x","StartPositionX:"..StartPosition.x)
		minetest.log("x","DigEndPositionX:"..DigEndPositionX)
		minetest.log("x","StartPositionY:"..StartPosition.y)
		minetest.log("x","DigEndPositionY:"..DigEndPositionY)
		minetest.log("x","StartPositionZ:"..StartPosition.z)
		minetest.log("x","DigEndPositionZ:"..DigEndPositionZ)
		-- Dig out the area and replace nodes
		-- Determine the start and end points for each axis (always looping from the lower number to the larger number)
		local startX, endX = math.min(StartPosition.x, DigEndPositionX), math.max(StartPosition.x, DigEndPositionX)
		local startY, endY = math.min(StartPosition.y, DigEndPositionY), math.max(StartPosition.y, DigEndPositionY)
		local startZ, endZ = math.min(StartPosition.z, DigEndPositionZ), math.max(StartPosition.z, DigEndPositionZ)

		-- Iterate over the specified range for each axis
		for x = startX, endX do
			for y = startY, endY do
				for z = startZ, endZ do
					minetest.set_node({x = x, y = y, z = z}, {name = ReplaceWith})
					--minetest.log("x","x,y,z:"..x..","..y..","..z)
					--minetest.log("x","replacewith:"..ReplaceWith)
				end
			end
		end
	
    -- Place the specified node at the specified location
    local place_position
    if PlaceLocation == 'T' then
        place_position = vector.new(StartPosition.x + math.floor(X_size / 2), EndPosition.y, StartPosition.z + math.floor(Z_size / 2))
    elseif PlaceLocation == 'B' then
        place_position = vector.new(StartPosition.x + math.floor(X_size / 2), StartPosition.y, StartPosition.z + math.floor(Z_size / 2))
    end

    minetest.set_node(place_position, {name = PlaceNode})
  minetest.log("hello","end")
    return EndPosition
end

--local StartPosition = {x = 0, y = -10, z = 0}
local X_size = 2
local Y_size = -30
local Z_size = 2
local DigAlongAxis = "Y"
local ReplaceWith = "air"
local PlaceNode = "default:cobble"
local PlaceLocation = "T"

minetest.register_node("mine_digger_api:mine_digger", {
    description = "Mine Digger",
    tiles = {"mine_digger.png"},
    groups = {cracky = 3, oddly_breakable_by_hand = 1},
    on_punch = function(pos, node, puncher)
         dig_area(pos, X_size, Y_size, Z_size, DigAlongAxis, ReplaceWith, PlaceNode, PlaceLocation)
    end,
})



--local EndPositionOut = dig_area(StartPosition, X_size, Y_size, Z_size, DigAlongAxis, ReplaceWith, PlaceNode, PlaceLocation)
minetest.log("x","finished")