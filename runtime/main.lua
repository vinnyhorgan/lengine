require("globals")
require("utils")

function love.load(args)
	math.randomseed(os.time())

	loader.require("objects")
	loader.require("states")

	state.registerEvents()
	state.switch(game, args)

	sc = state.current()
end