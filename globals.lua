loader = require("lib/loader")
state = require("lib/gamestate")
Object = require("lib/classic")
nuklear = require("nuklear")
json = require("lib/json")
signal = require("lib/signal")

lg = love.graphics
lf = love.filesystem
lm = love.mouse
lw = love.window

project = "test"

sc = nil