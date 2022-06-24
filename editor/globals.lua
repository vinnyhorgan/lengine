loader = require("lib/loader")
state = require("lib/gamestate")
Object = require("lib/classic")
nuklear = require("nuklear")
json = require("lib/json")
Camera = require("lib/camera")

lg = love.graphics
lf = love.filesystem
lm = love.mouse
lw = love.window
lk = love.keyboard

project = "test"

sc = state.current