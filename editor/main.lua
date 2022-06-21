require("globals")
require("utils")

function love.load()
	math.randomseed(os.time())

	loader.require("objects")
	loader.require("states")

	state.registerEvents()
	state.switch(splash)
end